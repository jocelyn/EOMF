note
	description: "Icon loader class generated by icondbc"
	keywords:    "Embedded icons"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2013- Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

class ICON_PAUSE

inherit
	ICON_SOURCE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			key := "pause"
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
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(34,6F,ED,60) A(9B,6D,EC,5E) A(DE,70,EE,61) A(FB,70,EF,62) A(FC,6E,ED,60) A(E0,69,E8,5A) 
					A(9E,61,E0,53) A(38,66,E5,58) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(9D,6F,EE,60) 
					A(FE,6B,EA,5D) A(FF,32,B0,22) A(FF,00,7D,00) A(FF,00,74,00) A(FF,00,7D,00) A(FF,16,93,05) A(FF,44,C2,35) A(FF,65,E4,57) A(A3,59,D7,4A) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(C2,71,EF,62) A(FF,4E,CC,3F) A(FF,00,57,00) A(FF,00,59,00) A(FF,00,72,00) A(FF,00,78,00) 
					A(FF,00,76,00) A(FF,00,6E,00) A(FF,00,66,00) A(FF,04,80,00) A(FF,5C,DB,4E) A(C9,54,D3,45) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(99,6F,EE,61) 
					A(FF,4F,CD,40) A(FF,00,43,00) A(FF,00,5D,00) A(FF,00,69,00) A(FF,00,72,00) A(FF,00,79,00) A(FF,00,77,00) A(FF,00,6E,00) A(FF,00,65,00) A(FF,00,5C,00) 
					A(FF,00,6C,00) A(FF,60,DE,51) A(A3,50,CE,41) A(00,00,00,00) A(2F,6F,ED,60) A(FE,6C,EB,5E) A(FF,00,52,00) A(FF,00,51,00) A(FF,00,5E,00) A(FF,00,66,00) 
					A(FF,00,6D,00) A(FF,00,71,00) A(FF,00,70,00) A(FF,00,6A,00) A(FF,00,62,00) A(FF,00,59,00) A(FF,00,51,00) A(FF,05,82,00) A(FF,61,E0,53) A(38,5E,DC,4F) 
					A(95,6C,EB,5E) A(FF,36,B3,26) A(FF,00,38,00) A(FF,00,51,00) A(FF,00,59,00) A(FF,00,5D,00) A(FF,04,81,00) A(FF,05,82,00) A(FF,04,81,00) A(FF,00,7B,00) 
					A(FF,00,67,00) A(FF,00,55,00) A(FF,00,4D,00) A(FF,00,49,00) A(FF,58,D6,49) A(9E,4B,C9,3C) A(D6,6F,ED,60) A(FF,00,73,00) A(FF,00,41,00) A(FF,00,4C,00) 
					A(FF,00,4C,00) A(00,7E,FD,70) A(00,7E,FD,70) A(FF,00,59,00) A(FF,00,5D,00) A(FF,7C,FB,6E) A(FF,6F,EE,61) A(FF,00,4C,00) A(FF,00,48,00) A(FF,00,42,00) 
					A(FF,24,A1,13) A(E0,4D,CB,3E) A(F5,6E,ED,60) A(FF,00,55,00) A(FF,00,41,00) A(FF,00,46,00) A(FF,00,46,00) A(00,7D,FC,6F) A(00,7E,FD,70) A(FF,00,55,00) 
					A(FF,00,4D,00) A(FF,7B,FA,6D) A(FF,6D,EC,5F) A(FF,00,46,00) A(FF,00,44,00) A(FF,00,3F,00) A(FF,0A,87,00) A(FC,4F,CD,40) A(F5,6C,EB,5E) A(FF,00,58,00) 
					A(FF,00,3D,00) A(FF,00,41,00) A(FF,00,41,00) A(00,77,F6,69) A(00,78,F7,6A) A(FF,00,44,00) A(FF,00,3F,00) A(FF,71,F0,63) A(FF,64,E3,56) A(FF,00,41,00) 
					A(FF,00,3F,00) A(FF,00,3A,00) A(FF,0B,88,00) A(FB,4C,CB,3D) A(D5,68,E6,59) A(FF,01,7D,00) A(FF,00,34,00) A(FF,00,3B,00) A(FF,00,3B,00) A(00,66,E4,57) 
					A(00,67,E5,58) A(FF,00,3F,00) A(FF,00,3A,00) A(FF,62,E0,53) A(FF,58,D6,49) A(FF,00,3B,00) A(FF,00,3A,00) A(FF,00,36,00) A(FF,2A,A7,1A) A(DE,46,C4,36) 
					A(92,60,DE,51) A(FF,46,C4,36) A(FF,00,2C,00) A(FF,00,36,00) A(FF,00,39,00) A(FF,00,4B,00) A(FF,00,67,00) A(FF,00,3A,00) A(FF,00,36,00) A(FF,00,63,00) 
					A(FF,00,4B,00) A(FF,00,38,00) A(FF,00,34,00) A(FF,00,37,00) A(FF,66,E5,58) A(9B,3F,BD,2F) A(2C,69,E7,5A) A(FD,64,E3,56) A(FF,00,66,00) A(FF,00,2E,00) 
					A(FF,00,33,00) A(FF,00,35,00) A(FF,00,36,00) A(FF,00,37,00) A(FF,00,37,00) A(FF,00,36,00) A(FF,00,34,00) A(FF,00,32,00) A(FF,00,2F,00) A(FF,0E,8B,00) 
					A(FE,5A,D8,4B) A(34,58,D6,49) A(00,00,00,00) A(93,59,D7,4A) A(FF,5F,DD,50) A(FF,00,4D,00) A(FF,00,2B,00) A(FF,00,2F,00) A(FF,00,30,00) A(FF,00,31,00) 
					A(FF,00,30,00) A(FF,00,2F,00) A(FF,00,2E,00) A(FF,00,2C,00) A(FF,00,64,00) A(FF,6F,EE,61) A(9C,3A,B8,2B) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(BB,52,D0,43) A(FF,62,E0,53) A(FF,00,73,00) A(FF,00,2C,00) A(FF,00,29,00) A(FF,00,2A,00) A(FF,00,2A,00) A(FF,00,29,00) A(FF,00,30,00) A(FF,0D,8A,00) 
					A(FF,6F,EE,61) A(C2,37,B5,27) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(93,4E,CC,3F) A(FD,5D,DB,4E) A(FF,5B,D9,4B) 
					A(FF,20,9D,0F) A(FF,04,80,00) A(FF,07,84,00) A(FF,2A,A8,1A) A(FF,68,E6,59) A(FE,57,D5,48) A(99,38,B6,28) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) 
					A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(2B,60,DF,51) A(92,48,C6,39) A(D4,4A,C8,3B) A(F4,4C,CA,3C) A(F5,4A,C8,3A) A(D6,44,C1,34) 
					A(95,3C,BA,2C) A(2F,58,D7,49) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) A(00,00,00,00) ;
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