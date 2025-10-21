
add_library(vcn OBJECT
  read_vcn_dec_stream.c
  read_vcn_enc_stream.c
  vcn_dec_parser.c
  vcn_enc_opcodes.c
)

target_link_libraries(vcn parson)
