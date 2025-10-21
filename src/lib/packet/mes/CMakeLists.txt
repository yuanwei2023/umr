
add_library(mes OBJECT
  read_mes_stream.c
)

target_link_libraries(mes parson)
