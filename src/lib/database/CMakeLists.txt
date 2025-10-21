add_library(umrdatabase
  open.c
  read_asic.c
  read_ip.c
  read_soc15.c
  scan.c
  match.c
  free_scan.c
)

target_link_libraries(umrdatabase umrcore parson)
install(TARGETS umrdatabase DESTINATION ${CMAKE_INSTALL_LIBDIR})
