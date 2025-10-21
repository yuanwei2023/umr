add_library(umrdiscover
  discover_by_did.c
  discover_by_ip_table.c
  discover_by_name.c
  discovery_table.c
)

target_link_libraries(umrdiscover umrcore parson)
install(TARGETS umrdiscover DESTINATION ${CMAKE_INSTALL_LIBDIR})
