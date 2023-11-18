
add_library(rumr
  buffer.c
  tcp_comm.c
  client.c
  umr_server.c
)

target_link_libraries(rumr ${REQUIRED_EXTERNAL_LIBS})
