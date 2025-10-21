
add_library(sdma OBJECT
  read_sdma_stream.c
  sdma_decode_opcodes.c
)

target_link_libraries(sdma parson)
