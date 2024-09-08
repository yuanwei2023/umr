# Try to find libdrm
#
# Once done, this will define
#
# LIBDRM_FOUND
# LIBDRM_INCLUDE_DIR
# LIBDRM_LIBRARIES

find_package(PkgConfig)

pkg_check_modules(PC_LIBDRM REQUIRED QUIET libdrm)

find_path(LIBDRM_INCLUDE_DIR NAMES amdgpu_drm.h
    HINTS
    ${PC_LIBDRM_INCLUDEDIR}
    ${PC_LIBDRM_INCLUDE_DIRS}
)

find_library(LIBDRM_LIBRARY NAMES libdrm_amdgpu.so.1
    HINTS
    ${PC_LIBDRM_LIBDIR}
    ${PC_LIBDRM_LIBRARY_DIRS}
)

SET(LIBDRM_LIBRARIES ${LIBDRM_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibDRM DEFAULT_MSG
	LIBDRM_LIBRARIES LIBDRM_INCLUDE_DIR
)

mark_as_advanced(LIBDRM_INCLUDE_DIR LIBDRM_LIBRARIES)
