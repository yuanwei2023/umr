
add_library(umrrumr
  buffer.c
  tcp_comm.c
  client.c
  umr_server.c
  rumr_serial_asic.c
)

target_link_libraries(umrrumr umrcore parson)
install(TARGETS umrrumr DESTINATION ${CMAKE_INSTALL_LIBDIR})
