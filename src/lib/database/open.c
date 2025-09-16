/*
 * Copyright (c) 2025 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * Authors: Tom St Denis <tom.stdenis@amd.com>
 */

#include "umr.h"

#include <archive.h>
#include <archive_entry.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

// Use 16k chunks for decompression
#define CHUNK 16384
#define COMPRESSED_DB_FILENAME "database.tar.zst"
#define HASH_FILENAME "database.sha256"

/**
 * @brief Create the database temp dir if it doesn't exist.
 * 
 * @return 1 if path exists, 0 if unable to create it.
 */
int ensureTempDir()
{
	mode_t mode = 0755; // Read, write, execute for owner, read execute for others

	if (mkdir(UMR_DB_TEMP_DIR, mode) == 0) {
		return 1;
	} else {
		if (errno == EEXIST) {
			return 1;
		}
	}

	return 0;
}

/** 
 * @brief Decompress database.tar.zst to get the given file in UMR_DB_TEMP_DIR
 *
 * @param archivepath The path that contains database.tar.zst to extract from
 * @param filename    The name of the database file to extract
 * @param binary      Flag indicating whether to open the file in binary mode (`1` for binary, `0` for text).
 * @return File pointer if able to extract, NULL if unable.
 */
FILE *umr_database_extract(char *archivepath, char *filename, int binary)
{
	char p[512];
	FILE *f;
	const char* mode = binary ? "rb" : "r";

	// First see if the database has changed since we extracted it.
	sprintf(p, "%s/%s", archivepath, HASH_FILENAME);
	FILE *hashf = fopen(p, "r");
	char* new_hash = NULL;
	if (hashf) {
		char line[128];
		if (fgets(line, sizeof(line), hashf)) {
			line[strcspn(line, "\r\n")] = 0; // Strip newline
			new_hash = strdup(line);
		}
		fclose(hashf);
	}	

	sprintf(p, "%s/%s", UMR_DB_TEMP_DIR, HASH_FILENAME);
	FILE *hashf2 = fopen(p, "r");
	if (hashf2 && new_hash) {
		char line[128];
		if (fgets(line, sizeof(line), hashf2)) {
			line[strcspn(line, "\r\n")] = 0; // Strip newline
			if (strcmp(line, new_hash) == 0) {
				// Database is the same, so no need to extract again.
				free(new_hash);
				fclose(hashf2);
				sprintf(p, "%s/%s", UMR_DB_TEMP_DIR, filename);
				f = fopen(p, mode);
				if (f) {
					return f;
				}
			}
		}
	}

	// Either extracted hash doesn't exist or it is different.
	
	// Otherwise open the archive
	// If we can't create the temp path, bail early.
	if (ensureTempDir() == 0) {
		return NULL;
	}

	char *c = getcwd(0, 0);
	chdir(UMR_DB_TEMP_DIR);

	sprintf(p, "%s%s", archivepath, COMPRESSED_DB_FILENAME);
	struct archive* ar;
	struct archive* ext;
	struct archive_entry *entry;
	int r;

	ar = archive_read_new();
	archive_read_support_format_tar(ar);
	archive_read_support_filter_zstd(ar);

	if ((r = archive_read_open_filename(ar, p, 10240))) {
		archive_read_free(ar);
		chdir(c);
		free(c);
		return NULL;
	}

	ext = archive_write_disk_new();
	archive_write_disk_set_options(ext, ARCHIVE_EXTRACT_TIME | ARCHIVE_EXTRACT_PERM | ARCHIVE_EXTRACT_ACL | ARCHIVE_EXTRACT_FFLAGS);
	archive_write_disk_set_standard_lookup(ext);

	while (archive_read_next_header(ar, &entry) == ARCHIVE_OK) {
		r = archive_write_header(ext, entry);
			if (r == ARCHIVE_OK) {
			const void *buff;
			size_t size;
			la_int64_t offset;

			while ((r = archive_read_data_block(ar, &buff, &size, &offset)) == ARCHIVE_OK) {
				archive_write_data_block(ext, buff, size, offset);
			}

			archive_write_finish_entry(ext);
		} else {
			archive_read_close(ar);
			archive_read_free(ar);
			archive_write_close(ext);
			archive_write_free(ext);
			chdir(c);
			free(c);
			return NULL;
		}
	}

	archive_read_close(ar);
	archive_read_free(ar);
	archive_write_close(ext);
	archive_write_free(ext);

	// Write database.sha256 into the temp dir so we know when we need to extract again later.
	sprintf(p, "%s/%s", UMR_DB_TEMP_DIR, HASH_FILENAME);
	hashf = fopen(p, "w");
	if (hashf) {
		fprintf(hashf, "%s\n", new_hash);
		fclose(hashf);
	}
	
	sprintf(p, "%s/%s", UMR_DB_TEMP_DIR, filename);
	f = fopen(p, mode);
	chdir(c);
	free(c);
	return f;
}

/**
 * @brief Opens a database file from various possible locations.
 *
 * This function attempts to open a specified database file using different methods:
 * 1. Directly from the provided filename.
 * 2. From a specified path combined with the filename.
 * 3. Using an environment variable path (`UMR_DATABASE_PATH`).
 * 4. Using a predefined directory (`UMR_DB_DIR`), if defined.
 * 5. Using the CMake source directory combined with `/database/`.
 *
 * @param path     The base path where the database file might be located (can be NULL).
 * @param filename The name of the database file to open.
 * @param binary   Flag indicating whether to open the file in binary mode (`1` for binary, `0` for text).
 * @return A pointer to the opened FILE structure if successful, or NULL if all attempts fail.
 */
FILE *umr_database_open(char *path, char *filename, int binary)
{
	FILE *f;
	char p[512];
	const char* mode = binary ? "rb" : "r";
	struct stat buffer;

	// 1. try to open it directly
	f = fopen(filename, mode);
	if (f)
		return f;

	// 2. if there is a path option used try that
	if (path && strlen(path)) {
		char *s = (path[strlen(path)-1] == '/') ? "" : "/";
		sprintf(p, "%s%s%s", path, s, filename);
		f = fopen(p, mode);
		if (f)
			return f;
	}

	// 3. try using an environment path
	path = getenv("UMR_DATABASE_PATH");
	if (path) {
		char *s = (path[strlen(path)-1] == '/') ? "" : "/";
		sprintf(p, "%s%s%s", path, s, filename);
		f = fopen(p, mode);
		if (f)
			return f;

		sprintf(p, "%s%s%s", path, s, COMPRESSED_DB_FILENAME);
		if (stat(p, &buffer) == 0) {
			f = umr_database_extract(path, filename, binary);
			if (f)
				return f;
		}
	}

	// 4. try using UMR_DB_DIR define
#ifdef UMR_DB_DIR
	sprintf(p, "%s%s", UMR_DB_DIR, filename);
	f = fopen(p, mode);
	if (f)
		return f;

	sprintf(p, "%s%s", UMR_DB_DIR, COMPRESSED_DB_FILENAME);
	if (stat(p, &buffer) == 0) {
		f = umr_database_extract(UMR_DB_DIR, filename, binary);
		if (f)
			return f;
	}

#endif

	// 5. try using CMAKE_SOURCE_DIR/database
	sprintf(p, "%s/database/%s", UMR_SOURCE_DIR, filename);
	f = fopen(p, mode);
	if (f)
		return f;

	sprintf(p, "%s/%s", UMR_SOURCE_DIR, COMPRESSED_DB_FILENAME);
	f = umr_database_extract(UMR_SOURCE_DIR, filename, binary);
	if (f)
		return f;
	
	// No options worked.
	return NULL;
}
