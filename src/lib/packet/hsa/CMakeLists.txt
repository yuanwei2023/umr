
add_library(hsa OBJECT
  read_hsa_stream.c
)

target_link_libraries(hsa parson)
