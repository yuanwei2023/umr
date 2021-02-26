# Try to find json-c
#
# Once done, this will define
#
# JSON_C_FOUND
# JSON_C_INCLUDE_DIR
# JSON_C_LIBRARIES

find_package(PkgConfig)

pkg_check_modules(PC_JSON_C QUIET json-c)

find_path(JSON_C_INCLUDE_DIR NAMES json_c_version.h
    HINTS
    ${PC_JSON_C_INCLUDEDIR}
    ${PC_JSON_C_INCLUDE_DIRS}
    /usr/include
    PATH_SUFFIXES json-c
)

find_library(JSON_C_LIBRARY NAMES json-c
    HINTS
    ${PC_JSON_C_LIBDIR}
    ${PC_JSON_C_LIBRARY_DIRS}
    /usr/lib64
    /usr/lib
)

SET(JSON_C_LIBRARIES ${JSON_C_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(JsonC DEFAULT_MSG
	JSON_C_LIBRARIES JSON_C_INCLUDE_DIR
)

mark_as_advanced(JSON_C_INCLUDE_DIR JSON_C_LIBRARIES)
