add_library(umrvm
  access_vram_ai.c
  access_vram_vi.c
  access_vram_via_mmio.c
  decode_pde_entry.c
  decode_pte_entry.c
  read_vram.c
)

target_link_libraries(umrvm umrcore parson)
install(TARGETS umrvm DESTINATION ${CMAKE_INSTALL_LIBDIR})
