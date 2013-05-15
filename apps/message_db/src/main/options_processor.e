note
	component:   "openEHR Archetype Project"
	description: "Options  definitions and processor for msgdb command line tool."
	keywords:    "Internationalisation, I18N, Localisation, L10N, command line"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2012- Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

class
	OPTIONS_PROCESSOR

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_parser
		end

	ARGUMENTS
		export
			{NONE} all
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Definitions

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (3)

			-- switches with arguments
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (locale_lang_switch, locale_lang_switch_desc, True, False, locale_lang_switch_arg, locale_lang_switch_arg_desc, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (msg_source_dir_switch, msg_source_dir_switch_desc, True, True, msg_source_dir_switch_arg, msg_source_dir_switch_arg, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (output_file_dir_switch, output_file_dir_switch_desc, True, False, output_file_dir_switch_arg, output_file_dir_switch_arg, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (classname_leader_switch, classname_leader_switch_desc, True, False, classname_leader_switch_arg, classname_leader_switch_arg, False))
		end

	classname_leader_switch: STRING = "c|classname_leader"
	classname_leader_switch_desc: STRING = "class name leader"
	classname_leader_switch_arg: STRING = "string"

	output_file_dir_switch: STRING = "o|output_dir"
	output_file_dir_switch_desc: STRING = "output directory"
	output_file_dir_switch_arg: STRING = "directory"

	msg_source_dir_switch: STRING = "s|source_dir"
	msg_source_dir_switch_desc: STRING = "source directory"
	msg_source_dir_switch_arg: STRING = "directory"

	locale_lang_switch: STRING = "l|lang"
	locale_lang_switch_desc: STRING = "language"
	locale_lang_switch_arg: STRING = "lang"
	locale_lang_switch_arg_desc: STRING = "language code"

feature {NONE} -- Initialization

	make (a_default_locale_lang: STRING)
			-- Initialize argument parser
		do
			default_locale_lang := a_default_locale_lang
			make_parser (False)
		end

feature -- Access

	default_locale_lang: STRING
			-- default locale

	msg_source_dirs: ARRAYED_LIST [STRING]
			-- message source directory; default to ".", i.e. current working directory of app
		require
			is_successful: is_successful
		once
			create Result.make (0)
			if has_option (msg_source_dir_switch) and then attached options_values_of_name (msg_source_dir_switch) as src_dirs then
				across src_dirs as src_dirs_csr loop
					Result.extend (src_dirs_csr.item)
				end
			else
				Result.extend (file_system.current_working_directory)
			end
		end

	output_file_dir: STRING
			-- message compiled class output directory; default to ".", i.e. current working directory of app
		require
			is_successful: is_successful
		once
			if has_option (output_file_dir_switch) and then attached option_of_name (output_file_dir_switch) as opt and then opt.has_value then
				Result := opt.value
			else
				Result := file_system.current_working_directory
			end
		end

	classname_leader: STRING
			-- leader to add to boilerplate generated classnames, will be XXXX_COMPILED_MESSAGE_DB and XXXX_COMPILED_MESSAGE_IDS
		require
			is_successful: is_successful
		once
			if has_option (classname_leader_switch) and then attached option_of_name (classname_leader_switch) as opt and then opt.has_value then
				Result := opt.value
			else
				Result := ""
			end
		end

	locale_lang: STRING
			-- language to use; default to system locale langeuage, short form, i.e. "en", "dk" etc.
		require
			is_successful: is_successful
		once
			if has_option (locale_lang_switch) and then attached option_of_name (locale_lang_switch) as opt and then opt.has_value then
				Result := opt.value
			else
				Result := default_locale_lang
			end
		end

feature {NONE} -- Usage

	copyright: STRING = "Copyright (c) 2012- openEHR Foundation"
			--  <Precursor>

	name: STRING
			--  <Precursor>
		once
			Result := command_name
		end

	version: STRING
			--  <Precursor>
		once
			Result := "0.9.0"
		end

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
--| The Original Code is shared_ui_resources.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2004
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
