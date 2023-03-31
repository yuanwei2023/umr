# Copyright 2017 Edward O'Callaghan <funfunctor@folklore1984.net>

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/)

if(UMR_GUI)
  # this definition is used by 'app' and 'test' subdirectories
  add_compile_definitions(UMR_GUI_SERVER=1)
  add_subdirectory(test)
endif()

add_subdirectory(lib)
add_subdirectory(app)

set(headers umr.h umrapp.h)

install(FILES ${headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
