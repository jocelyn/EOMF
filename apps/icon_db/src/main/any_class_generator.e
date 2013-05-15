note
	component:   "openEHR Project <http://www.openEHR.org>"
	description : "[
					Parent of class generator classes, with basic facilities for populating standard 
					note fields like author, copyright etc.

					Use `make' to set up the class and `generate' to do the generation.

					If the class name doesn't need to change over invocations of `generate', the descendant
					can just implement `default_class_name' to the required value.

					Otherwise, the `class_name' attribute may be set on every generation (i.e. to have the
					effect of generating distinct classes) by calling `generate_as_class'.
				   ]"
	keywords:    "embedded icons, pixmaps, class generation"
	author:      "Thomas Beale <thomas.beale@OceanInformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2012- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "See notice at bottom of class"

deferred class
	ANY_CLASS_GENERATOR

feature -- Definitions

	default_class_name: STRING
		deferred
		end

feature -- Initialization

	make (an_author_note, a_support_note, a_copyright_note: STRING)
		do
			author_note := an_author_note
			support_note := a_support_note
			copyright_note := a_copyright_note
			create output.make (50000)
			class_name := default_class_name.twin
		end

feature -- Access

	class_name: STRING

	author_note: STRING

	support_note: STRING

	copyright_note: STRING

	output: STRING
			-- class text

feature -- Commands

	generate_as_class (a_class_name: STRING)
		do
			class_name := a_class_name
			generate
		end

	generate
		do
			output.wipe_out

			-- class header parts
			output.append (class_header)
			output.replace_substring_all ("$CLASS_NAME", class_name)
			output.replace_substring_all ("$AUTHOR", author_note)
			output.replace_substring_all ("$SUPPORT", support_note)
			output.replace_substring_all ("$COPYRIGHT", copyright_note)
			output.append ("%N")

			output.append (class_inherit_clause)
			output.append ("%N")
			output.append (class_create_clause)
			output.append ("%N")
			output.append (class_initialisation)
			output.append ("%N")

			-- main part of class
			generate_body

			-- class footer
			output.append (class_footer)
		end

feature {NONE} -- Implementation

	generate_body
		deferred
		end

feature {NONE} -- Boilerplate

	class_header: STRING = "[
note
	description: "Icon loader class generated by icondbc"
	keywords:    "Embedded icons"
	author:      "$AUTHOR"
	support:     "$SUPPORT"
	copyright:   "$COPYRIGHT"
	license:     "See notice at bottom of class"

class $CLASS_NAME

	]"

	class_inherit_clause: STRING
		deferred
		end

	class_create_clause: STRING
		deferred
		end

	class_initialisation: STRING
		deferred
		end

	class_footer: STRING = "[
end
	]"

end


--|
--| ***** BEGIN LICENSE BLOCK *****
--| Version: MPL 1.1/GPL 2.0/LGPL 2.1
--|
--| The contents of this file are subject to the Mozilla Public License Version
--| 1.1 (the 'License'); you may not use this file except in compliance with
--| the License. You may obtain a copy of the License at
--| http://www.mozilla.org/MPL/
--|
--| Software distributed under the License is distributed on an 'AS IS' basis,
--| WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
--| for the specific language governing rights and limitations under the
--| License.
--|
--| The Original Code is icon_class_generator.e
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2013-
--| the Initial Developer. All Rights Reserved.
--|
--| Contributor(s):
--|
--| Alternatively, the contents of this file may be used under the terms of
--| either the GNU General Public License Version 2 or later (the 'GPL'), or
--| the GNU Lesser General Public License Version 2.1 or later (the 'LGPL'),
--| in which case the provisions of the GPL or the LGPL are applicable instead
--| of those above. If you wish to allow use of your version of this file only
--| under the terms of either the GPL or the LGPL, and not to allow others to
--| use your version of this file under the terms of the MPL, indicate your
--| decision by deleting the provisions above and replace them with the notice
--| and other provisions required by the GPL or the LGPL. If you do not delete
--| the provisions above, a recipient may use your version of this file under
--| the terms of any one of the MPL, the GPL or the LGPL.
--|
--| ***** END LICENSE BLOCK *****
--|