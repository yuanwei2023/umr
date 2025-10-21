
add_library(umsch OBJECT
  read_umsch_stream.c
)

target_link_libraries(umsch parson)
