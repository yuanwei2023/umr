
add_library(pm4 OBJECT
  pm4_decode_opcodes.c
  pm4_lite.c
  read_pm4_stream.c
)

target_link_libraries(pm4 parson)
