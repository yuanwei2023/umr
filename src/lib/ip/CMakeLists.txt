# Copyright 2017 Edward O'Callaghan <funfunctor@folklore1984.net>

add_library(ip OBJECT
  athub200.c
  bif30.c
  bif41.c
  bif50.c
  bif51.c
  clk1002.c
  clk1100.c
  dce100.c
  dce110.c
  dce112.c
  dce120.c
  dce60.c
  dce80.c
  dcn10.c
  dcn200.c
  dcn210.c
  dpcs210.c
  gfx60.c
  gfx70.c
  gfx72.c
  gfx80.c
  gfx81.c
  gfx90.c
  gfx91.c
  gfx921.c
  gfx1010.c
  gmc60.c
  gmc70.c
  gmc81.c
  hdp40.c
  hdp500.c
  mmhub10.c
  mmhub200.c
  mmhub91.c
  mmhub930.c
  mmhub941.c
  mp90.c
  mp100.c
  mp1100.c
  mp1200.c
  nbio61.c
  nbio70.c
  nbio230.c
  oss10.c
  oss20.c
  oss30.c
  oss40.c
  oss401.c
  oss50.c
  sdma040.c
  sdma041.c
  sdma042.c
  sdma140.c
  sdma142.c
  sdma0422.c
  sdma1422.c
  sdma2422.c
  sdma3422.c
  sdma4422.c
  sdma5422.c
  sdma6422.c
  sdma7422.c
  smu60.c
  smu700.c
  smu701.c
  smu711.c
  smu712.c
  smu713.c
  smu80.c
  smu1100.c
  thm90.c
  thm1102.c
  umc60.c
  uvd40.c
  uvd42.c
  uvd5.c
  uvd6.c
  uvd70.c
  vce1.c
  vce2.c
  vce3.c
  vce40.c
  vcn10.c
  vcn200.c
  vcn250.c
)

if(MSVC)
	# force static runtime libraries for msvc builds.
	# The DK's boost is using the static RTL and if we 
	# don't use the same RTL version we get link errors.
	set(variables 
		CMAKE_C_FLAGS_DEBUG
		CMAKE_C_FLAGS_RELEASE
		CMAKE_C_FLAGS_RELWITHDEBINFO
		CMAKE_C_FLAGS_MINSIZEREL
	)
		foreach(variable ${variables})
		if(${variable} MATCHES "/MD")
			string(REGEX REPLACE "/MD" "/MT" ${variable} "${${variable}}")
		endif()
		endforeach()
	endif()
