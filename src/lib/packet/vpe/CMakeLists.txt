
add_library(vpe OBJECT
  read_vpe_stream.c
  vpe_decode_opcodes.c
)

target_link_libraries(vpe parson)
