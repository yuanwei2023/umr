# Copyright 2017 Edward O'Callaghan <funfunctor@folklore1984.net>

project(umrtestapp)

add_executable(umrtest
  testing_harness.c
  test_framework.c
  main.c

  test_mmio.c
)

target_link_libraries(umrtest umrcore)
target_link_libraries(umrtest umrlow)
target_link_libraries(umrtest umrcore) #circular dependency umrcode->umrlow->umrcore

target_link_libraries(umrtest ${LLVM_LIBS})
target_link_libraries(umrtest ${REQUIRED_EXTERNAL_LIBS})
