# Copyright 2017 Edward O'Callaghan <funfunctor@folklore1984.net>

set(CPACK_RPM_COMPONENT_INSTALL ON)
set(CPACK_DEB_COMPONENT_INSTALL ON)
cmake_minimum_required(VERSION 3.0.1)

project(umr)

include(GNUInstallDirs)

SET(MAJOR_VERSION 1)
SET(MINOR_VERSION 0)

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "User mode register debugger for AMDGPU devices using IP cleared registers/definitions.")
SET(CPACK_PACKAGE_VENDOR "AMD")
SET(CPACK_PACKAGE_CONTACT "tom.stdenis@amd.com")
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README")
SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
SET(CPACK_RPM_PACKAGE_GROUP "System/Monitoring")
SET(CPACK_PACKAGE_VERSION_MAJOR ${MAJOR_VERSION})
SET(CPACK_PACKAGE_VERSION_MINOR ${MINOR_VERSION})
SET(CPACK_GENERATOR "RPM;DEB")

include(CPack)


SET(RELEASE_VERSION \"${MAJOR_VERSION}.${MINOR_VERSION}\")
execute_process(COMMAND  git describe --abbrev=12 --always
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
    OUTPUT_VARIABLE GIT_REV
)
execute_process(COMMAND  git branch --show-current
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
    OUTPUT_VARIABLE GIT_BRANCH
)
add_definitions(-DUMR_BUILD_VER=${RELEASE_VERSION})
add_definitions(-DUMR_BUILD_REV=\"${GIT_REV}\")
add_definitions(-DUMR_BUILD_BRANCH=\"${GIT_BRANCH}\")
add_definitions(-DUMR_DB_DIR=\"${CMAKE_INSTALL_FULL_DATADIR}/umr/database/\")
add_definitions(-DUMR_SOURCE_DIR=\"${CMAKE_SOURCE_DIR}\")

# Add local repository for FindXXX.cmake modules.
SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake_modules/" ${CMAKE_MODULE_PATH})

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
find_package(Threads REQUIRED)

find_package(Curses REQUIRED)
include_directories(${CURSES_INCLUDE_DIRS})

find_package(PCIAccess REQUIRED)
include_directories(${PCIACCESS_INCLUDE_DIR})

option(UMR_NO_DRM "Disable libdrm functions to read memory stats" OFF)
option(UMR_NO_LLVM "Disable LLVM shader disasm functions, suggested for LLVM < 7" OFF)
option(UMR_NEED_RT "Link against RT library, needed for older glibc versions" OFF)
option(UMR_NO_GUI "Disable umr --server and --gui options" OFF)

if(UMR_NO_DRM)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUMR_NO_DRM")
else()
find_package(LibDRM REQUIRED)
include_directories(${LIBDRM_INCLUDE_DIR})
endif()

if(UMR_NO_LLVM)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUMR_NO_LLVM")
else()
find_package(LLVM REQUIRED COMPONENTS all)
include_directories(${LLVM_INCLUDE_DIRS})

if(LLVM_CMAKE_DIR)
  list(APPEND CMAKE_MODULE_PATH ${LLVM_CMAKE_DIR})
  include(AddLLVM)

  if (LLVM_LINK_LLVM_DYLIB)
    set(LLVM_LIBS LLVM)
  else()
    LLVM_MAP_COMPONENTS_TO_LIBNAMES(LLVM_LIBS
      AllTargetsDescs
      AllTargetsDisassemblers
      AllTargetsInfos
      MC
      Support
      MCDisassembler
    )
  endif()
endif()
endif()

if (NOT UMR_NO_GUI)
find_package(SDL2 REQUIRED)
find_package(NanoMsg)
include_directories(${SDL2_INCLUDE_DIRS})
  if (NANOMSG_FOUND)
    include_directories(${NANOMSG_INCLUDE_DIR})
    set(REQUIRED_EXTERNAL_LIBS_GUI ${NANOMSG_LIBRARIES} ${SDL2_LIBRARIES})
    set(UMR_GUI_REMOTE 1)
  else()
    message("nanomsg library not found. The remote GUI options won't be available.")
    set(REQUIRED_EXTERNAL_LIBS_GUI ${SDL2_LIBRARIES})
    set(UMR_GUI_REMOTE 0)
  endif()
endif()

if(UMR_NEED_RT)
set(RT_LIBS "-lrt")
else()
set(RT_LIBS "")
endif()

set(REQUIRED_EXTERNAL_LIBS
  ${CURSES_LIBRARIES}
  ${PCIACCESS_LIBRARIES}
  Threads::Threads
  ${LLVM_LIBS}
  ${RT_LIBS}
  ${REQUIRED_EXTERNAL_LIBS_GUI}
)

# Global setting: build everything position independent
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# CFLAGS += -Wall -W -O2 -g3 -Isrc/ -DPIC -fPIC
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -W -g3 -pedantic -Werror=format-security -Wunused-result")

add_subdirectory(src)
add_subdirectory(doc)
