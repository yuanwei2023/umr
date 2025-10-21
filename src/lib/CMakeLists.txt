# Copyright 2017 Edward O'Callaghan <funfunctor@folklore1984.net>

add_subdirectory(database)
add_subdirectory(lowlevel)
add_subdirectory(rumr)
add_subdirectory(vm)
add_subdirectory(packet)
add_subdirectory(discover)

add_library(umrcore
  get_gfx_version.c
  read_user_queue.c
  apply_bank_address.c
  apply_callbacks.c
  bitfield_print.c
  close_asic.c
  create_mmio_accel.c
  decode_metrics.c
  find_ip.c
  find_reg.c
  free_asic_blocks.c
  ih_decode_vectors.c
  get_ip_rev.c
  mmio.c
  mqd_decode.c
  ring_is_halted.c
  scan_config.c
  scan_waves.c
  shader_disasm.c
  sq_cmd_halt_waves.c
  testing_harness.c
  version.c
  $<TARGET_OBJECTS:umrdatabase>
  $<TARGET_OBJECTS:umrrumr>
  $<TARGET_OBJECTS:umrvm>
  $<TARGET_OBJECTS:umrpacket>
  $<TARGET_OBJECTS:umrdiscover>
)

target_link_libraries(umrcore umrpacket umrvm umrdatabase umrrumr umrdiscover ${REQUIRED_EXTERNAL_LIBS})

install(TARGETS umrcore umrpacket umrvm umrdatabase umrrumr umrdiscover DESTINATION ${CMAKE_INSTALL_LIBDIR})
