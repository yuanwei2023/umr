add_subdirectory(hsa)
add_subdirectory(mes)
add_subdirectory(pm4)
add_subdirectory(sdma)
add_subdirectory(umsch)
add_subdirectory(vcn)
add_subdirectory(vpe)

add_library(umrpacket
  packet_stream.c
  $<TARGET_OBJECTS:hsa>
  $<TARGET_OBJECTS:mes>
  $<TARGET_OBJECTS:pm4>
  $<TARGET_OBJECTS:sdma>
  $<TARGET_OBJECTS:umsch>
  $<TARGET_OBJECTS:vcn>
  $<TARGET_OBJECTS:vpe>
)

target_link_libraries(umrpacket umrcore parson)
install(TARGETS umrpacket DESTINATION ${CMAKE_INSTALL_LIBDIR})
