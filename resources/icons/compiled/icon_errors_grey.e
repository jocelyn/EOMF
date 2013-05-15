note
	description: "Icon loader class generated by icondbc"
	keywords:    "Embedded icons"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2013- Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

class ICON_ERRORS_GREY

inherit
	ICON_SOURCE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			key := "errors_grey"
			make_with_size (16, 16)
			fill_memory
		end

feature {NONE} -- Image data
	
	c_colors_0 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"{
				{
					#define B(q) #q
					#ifdef EIF_WINDOWS
						#define A(a,r,g,b) B(\x##b\x##g\x##r\x##a)
					#else
						#define A(a,r,g,b) B(\x##r\x##g\x##b\x##a)
					#endif

					char l_data[] =
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,16,16,16) A(FF,6F,6F,6F) A(FF,6E,6E,6E) A(FF,15,15,15) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(FF,17,17,17) A(FF,4D,4D,4D) A(FF,D2,D2,D2) A(FF,C4,C4,C4) A(FF,4D,4D,4D) A(FF,15,15,15) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,2F,2F,2F) A(FF,4F,4F,4F) A(FF,D8,D8,D8) A(FF,FF,FF,FF) 
					A(FF,FF,FF,FF) A(FF,C5,C5,C5) A(FF,4C,4C,4C) A(FF,16,16,16) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(FF,46,46,46) A(FF,51,51,51) A(FF,D8,D8,D8) A(FF,FF,FF,FF) A(FF,FF,FF,FF) A(FF,FF,FF,FF) A(FF,FF,FF,FF) A(FF,BE,BE,BE) A(FF,4C,4C,4C) 
					A(FF,16,16,16) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,46,46,46) A(FF,54,54,54) A(FF,D8,D8,D8) A(FF,FF,FF,FF) 
					A(FF,FF,FF,FF) A(FF,47,47,47) A(FF,43,43,43) A(FF,FF,FF,FF) A(FF,FC,FC,FC) A(FF,B3,B3,B3) A(FF,47,47,47) A(FF,16,16,16) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(FF,46,46,46) A(FF,57,57,57) A(FF,DA,DA,DA) A(FF,FF,FF,FF) A(FF,FF,FF,FF) A(FF,FF,FF,FF) A(FF,76,76,76) A(FF,6F,6F,6F) A(FF,F5,F5,F5) 
					A(FF,EE,EE,EE) A(FF,E5,E5,E5) A(FF,A3,A3,A3) A(FF,47,47,47) A(FF,16,16,16) A(00,00,00,00) A(FF,3F,3F,3F) A(FF,59,59,59) A(FF,D8,D8,D8) A(FF,FE,FE,FE) 
					A(FF,FC,FC,FC) A(FF,F9,F9,F9) A(FF,F6,F6,F6) A(FF,7D,7D,7D) A(FF,70,70,70) A(FF,CF,CF,CF) A(FF,C3,C3,C3) A(FF,BF,BF,BF) A(FF,BE,BE,BE) A(FF,94,94,94) 
					A(FF,4A,4A,4A) A(FF,11,11,11) A(FF,0D,0D,0D) A(FF,AC,AC,AC) A(FF,F2,F2,F2) A(FF,EF,EF,EF) A(FF,ED,ED,ED) A(FF,EA,EA,EA) A(FF,DD,DD,DD) A(FF,7A,7A,7A) 
					A(FF,6D,6D,6D) A(FF,B8,B8,B8) A(FF,B8,B8,B8) A(FF,B7,B7,B7) A(FF,B7,B7,B7) A(FF,B7,B7,B7) A(FF,69,69,69) A(FF,07,07,07) A(FF,00,00,00) A(FF,32,32,32) 
					A(FF,D7,D7,D7) A(FF,DF,DF,DF) A(FF,DD,DD,DD) A(FF,C7,C7,C7) A(FF,B5,B5,B5) A(FF,9C,9C,9C) A(FF,98,98,98) A(FF,B2,B2,B2) A(FF,B2,B2,B2) A(FF,B2,B2,B2) 
					A(FF,B2,B2,B2) A(FF,A7,A7,A7) A(FF,1F,1F,1F) A(FF,00,00,00) A(00,00,00,00) A(FF,00,00,00) A(FF,2F,2F,2F) A(FF,C6,C6,C6) A(FF,BA,BA,BA) A(FF,B0,B0,B0) 
					A(FF,AF,AF,AF) A(FF,60,60,60) A(FF,53,53,53) A(FF,AE,AE,AE) A(FF,AE,AE,AE) A(FF,AE,AE,AE) A(FF,A1,A1,A1) A(FF,1C,1C,1C) A(FF,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(FF,00,00,00) A(FF,29,29,29) A(FF,A9,A9,A9) A(FF,AC,AC,AC) A(FF,AB,AB,AB) A(FF,5F,5F,5F) A(FF,54,54,54) A(FF,AB,AB,AB) 
					A(FF,AC,AC,AC) A(FF,9C,9C,9C) A(FF,17,17,17) A(FF,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,00,00,00) 
					A(FF,24,24,24) A(FF,A4,A4,A4) A(FF,A9,A9,A9) A(FF,B9,B9,B9) A(FF,BC,BC,BC) A(FF,A9,A9,A9) A(FF,96,96,96) A(FF,14,14,14) A(FF,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,00,00,00) A(FF,21,21,21) A(FF,9F,9F,9F) A(FF,A7,A7,A7) 
					A(FF,A7,A7,A7) A(FF,92,92,92) A(FF,10,10,10) A(FF,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,00,00,00) A(FF,1D,1D,1D) A(FF,9D,9D,9D) A(FF,8F,8F,8F) A(FF,0C,0C,0C) A(FF,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,00,00,00) A(FF,00,00,00) A(FF,00,00,00) 
					A(FF,00,00,00) A(FF,07,07,07) A(FF,05,05,05) A(FF,00,00,00) A(FF,00,00,00) A(FF,00,00,00) A(FF,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(FF,00,00,00) A(FF,00,00,00) A(FF,00,00,00) A(FF,00,00,00) A(FF,00,00,00) A(FF,00,00,00) A(FF,00,00,00) 
					A(FF,00,00,00) A(FF,00,00,00) A(FF,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) ;
					memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
				}
			}"
		end

	build_colors (a_ptr: POINTER)
			-- Build `colors'
		do
			c_colors_0 (a_ptr, 0)
		end

end