# Copyright 2017 Edward O'Callaghan <funfunctor@folklore1984.net>

add_subdirectory(database)
add_subdirectory(lowlevel)

add_library(umrcore STATIC
  add_ip_block.c
  bitfield_print.c
  close_asic.c
  create_mmio_accel.c
  decode_metrics.c
  discover_by_did.c
  discover_by_name.c
  dump_ib.c
  find_reg.c
  mmio.c
  read_vram.c
  ring_decode.c
  scan_config.c
  scan_waves.c
  shader_disasm.c
  sq_cmd_halt_waves.c
  umr_apply_bank_address.c
  umr_apply_callbacks.c
  umr_ih_decode_vectors.c
  umr_read_pm4_stream.c
  umr_read_sdma_stream.c
  umr_pm4_decode_opcodes.c
  umr_sdma_decode_opcodes.c
  version.c
  $<TARGET_OBJECTS:database>
)

target_link_libraries(umrcore ${REQUIRED_EXTERNAL_LIBS})

install(TARGETS umrcore DESTINATION ${CMAKE_INSTALL_LIBDIR})
