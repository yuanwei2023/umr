# Copyright 2017 Edward O'Callaghan <funfunctor@folklore1984.net>

project(umrtestapp)

include_directories("../app/gui/parson")
include_directories("../app")

set (TEST_SRC test_framework.c
  main.c
  test_mmio.c
  test_vm.c
  ../app/gui/parson/parson.c
  ../app/server.c
)

if(NOT UMR_NO_GUI OR NOT UMR_NO_SERVER)
  add_compile_definitions(COMMANDS_TEST=1)
  set (TEST_SRC ${TEST_SRC} test_server.c ../app/gui/parson/parson.c ../app/gui/commands.c)
endif()

add_executable(umrtest ${TEST_SRC})

if(NOT UMR_NO_GUI OR NOT UMR_NO_SERVER)
  target_link_libraries(umrtest EGL drm gbm GL)
endif()

target_link_libraries(umrtest umrcore)
target_link_libraries(umrtest umrlow)
target_link_libraries(umrtest umrcore) #circular dependency umrcode->umrlow->umrcore

target_link_libraries(umrtest ${LLVM_LIBS})
target_link_libraries(umrtest ${REQUIRED_EXTERNAL_LIBS})
