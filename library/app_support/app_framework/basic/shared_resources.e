note
	component:   "Eiffel Object Modelling Framework"
	description: "Shared access to application-wide configuration settings for any Eiffel app, stored in a config file."
	keywords:    "config, resources"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2003- openEHR Foundation <http://www.openEHR.org>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class SHARED_RESOURCES

inherit
	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all;
			{ANY} deep_copy, deep_twin, is_deep_equal, standard_is_equal
		end

	ERROR_SEVERITY_TYPES
		export
			{NONE} all
		end

feature -- Definitions

	Default_windows_temp_dir: STRING = "C:\Temp"

	Default_unix_temp_dir: STRING = "/tmp"

	User_config_file_extension: STRING = ".cfg"

	Default_editor_app_command: STRING
			-- An editor application based on operating system.
		once
   			if is_windows then
   				Result := "cmd /q /d /c start %"%" /b"
			elseif is_mac_os_x then
				Result := "open"
			else
   				Result := "vi"
   			end
   		end

	Default_text_editor_command: STRING
			-- A reasonable name of a text editor based on operating system.
		once
   			if is_windows then
   				Result := "Notepad.exe"
			elseif is_mac_os_x then
				Result := "open -t"
			else
   				Result := "vi"
   			end
   		end

	Default_difftool_command: STRING
			-- A reasonable diff tool based on operating system.
		once
   			if is_windows then
   				-- /e = enable tool to be dismissed with single Esc keystroke, like a dialog
   				-- /u means don't add any paths to Windows recent paths / places
   				Result := "%"C:\Program Files\winmerge\winmergeU.exe%" /e /u /f *.*"
			else
   				Result := "sdiff"
   			end
   		end

	Resource_path_separator: STRING = "/"
			-- regardless of OS, this is used in paths to locate resources, including icons and also .cfg file items

feature -- Environment

	std_out: PLAIN_TEXT_FILE
		do
			Result := io.output
		end

	std_err: PLAIN_TEXT_FILE
		do
			Result := io.error
		end

	is_windows: BOOLEAN
			-- Is the operating system Microsoft Windows?
		once
			Result := operating_system.is_windows
		end

	is_unix: BOOLEAN
			-- Is the operating system some form of Unix?
		once
			Result := operating_system.is_unix
		end

	is_mac_os_x: BOOLEAN
			-- Is the operating system Mac OS X?
		once
			Result := {PLATFORM}.is_mac
		end

	system_temp_file_directory: STRING
			-- Standard place for temporary files.
			-- By default /tmp on unix-like systems and C:\Temp on windows-like systems.
			-- Windows would normally be "C:\Documents and Settings\(user)\Local Settings\Temp".
		local
			tmp_dir: detachable STRING
		once
			tmp_dir := execution_environment.get ("TMP")

			if not attached tmp_dir or else tmp_dir.is_empty then
				tmp_dir := execution_environment.get ("TEMP")
			end

			if attached tmp_dir as t and then not t.is_empty then
				Result := (create {WINDOWS_SHORT_PATH}.make (t)).as_long_path
			else
				if is_windows then
					Result := default_windows_temp_dir.twin
				else
					Result := default_unix_temp_dir.twin
				end
			end

			Result.prune_all_trailing (os_directory_separator)
			Result.append_character (os_directory_separator)
		ensure
			not_empty: not Result.is_empty
			ends_with_directory_separator: Result @ Result.count = os_directory_separator
		end

feature  {NONE} -- Conversion

	substitute_env_vars (s: STRING): STRING
			-- expand the environment variables, delimited by a '$' and any
			-- non alphanumeric character except underscore, or end of string,
			-- in the string s
		local
			i, p,q: INTEGER
			var_name: STRING
			c: CHARACTER
		do
			Result := s.twin
			from
				p := s.index_of('$', 1)
				q := p+1
			until
				p = 0
			loop
				from i := q until i = 0 loop
					c := s.item(i)
					if (c >= 'a' and c <= 'z') or else
						(c >= 'A' and c <= 'Z') or else
						(c >= '0' and c <= '9') or else
						c = '_' then
						q := q + 1
						i := i + 1
						if i > s.count then
							i := 0
							q := s.count
						end
					else
						i := 0
					end
				end

				var_name := s.substring(p+1, q)
				if attached execution_environment.get(var_name) as var_val then
					Result.replace_substring_all("$" + var_name, var_val)
				end
				p := s.index_of('$', q)
			end
		end

feature {NONE} -- Access

	execution_environment: EXECUTION_ENVIRONMENT
			-- Shared instance of the execution environment.
	    once
	        create Result
	    end

	current_working_directory: STRING
		do
			Result := execution_environment.current_working_directory
		end

	os_directory_separator: CHARACTER
	    once
			Result := operating_environment.directory_separator
	    end

feature {NONE} -- Implementation

	file_exists (path: STRING): BOOLEAN
			-- Is `path' a valid, existing file?
		do
			Result := file_system.file_exists (file_system.canonical_pathname (path))
		end

	directory_exists (path: STRING): BOOLEAN
			-- Is `path' a valid, existing directory?
		do
			Result := file_system.directory_exists (file_system.canonical_pathname (path))
		end

	extension_replaced (path, new_extension: STRING): STRING
			-- Copy of `path', with its extension replaced by `new_extension'.
		require
			new_extension_starts_with_dot: not new_extension.is_empty implies new_extension.item (1) = '.'
		local
			n: INTEGER
		do
			n := path.count
			Result := path.twin
			Result.replace_substring (new_extension, n - file_system.extension (path).count + 1, n)
		ensure
			cloned: Result /= path
			ends_with_new_extension: Result.ends_with (new_extension)
		end

	extension_removed (path: STRING): STRING
			-- Copy of `path', with its extension (final segment preceded by '.'), if any, removed
		do
			Result := path.substring (1, path.count - file_system.extension (path).count)
		ensure
			cloned: Result /= path
			extension_removed: path.has ('.') implies path.count > Result.count
		end

end

