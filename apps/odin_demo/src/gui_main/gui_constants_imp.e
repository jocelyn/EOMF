note
	description: "[
			Objects that provide access to constants, possibly loaded from a files.
			Each constant is generated into two features: both a query and a storage
			feature. For example, for a STRING constant named `my_string', the following
			features are generated: my_string: STRING and my_string_cell: CELL [STRING].
			`my_string' simply returns the current item of `my_string_cell'. By seperating
			the constant access in this way, it is possible to change the constant's value
			by either redefining `my_string' in descendent classes or simply performing
			my_string_cell.put ("new_string") as required.
			If you are loading the constants from a file and you wish to reload a different set
			of constants for your interface (e.g. for multi-language support), you may perform
			this in the following way:
			
			set_file_name ("my_constants_file.text")
			reload_constants_from_file
			
			and then for each generated widget, call `set_all_attributes_using_constants' to reset
			the newly loaded constants into the attribute settings of each widget that relies on constants.
			
			Note that if you wish your constants file to be loaded from a specific location,
			you may redefine `initialize_constants' to handle the loading of the file from
			an alternative location.
			
			Note that if you have selected to load constants from a file, and the file cannot
			be loaded, you will get a precondition violation when attempting to access one
			of the constants that should have been loaded. Therefore, you must ensure that either the
			file is accessible or you do not specify to load from a file.
		]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GUI_CONSTANTS_IMP
	
feature {NONE} -- Initialization

	initialize_constants
			-- Load all constants from file.
		local
			file: PLAIN_TEXT_FILE
		do
			if not constants_initialized then
				create file.make (file_name)
				if file.exists then
					file.open_read
					file.readstream (file.count)
					file.close
					parse_file_contents (file.laststring)
				end
				initialized_cell.put (True)
			end
		ensure
			initialized: constants_initialized
		end

feature -- Access

	reload_constants_from_file
			-- Re-load all constants from file named `file_name'.
			-- When used in conjunction with `set_file_name', it enables
			-- you to load a fresh set of INTEGER and STRING constants
			-- from a constants file. If you then wish these to be applied
			-- to a current generated interface, call `set_all_attributes_using_constants'
			-- on that interface for the changed constants to be reflected in the attributes
			-- of your widgets.
		do
			initialized_cell.put (False)
			initialize_constants
		end

	app_min_height: INTEGER
			-- `Result' is INTEGER constant named `app_min_height'.
		do
			Result := app_min_height_cell.item
		end

	app_min_height_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `app_min_height'.
		once
			create Result.put (350)
		end

	app_max_width: INTEGER
			-- `Result' is INTEGER constant named `app_max_width'.
		do
			Result := app_max_width_cell.item
		end

	app_max_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `app_max_width'.
		once
			create Result.put (2000)
		end

	app_initial_height: INTEGER
			-- `Result' is INTEGER constant named `app_initial_height'.
		do
			Result := app_initial_height_cell.item
		end

	app_initial_height_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `app_initial_height'.
		once
			create Result.put (768)
		end

	padding_width: INTEGER
			-- `Result' is INTEGER constant named `padding_width'.
		do
			Result := padding_width_cell.item
		end

	padding_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `padding_width'.
		once
			create Result.put (3)
		end

	app_min_width: INTEGER
			-- `Result' is INTEGER constant named `app_min_width'.
		do
			Result := app_min_width_cell.item
		end

	app_min_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `app_min_width'.
		once
			create Result.put (500)
		end

	app_max_height: INTEGER
			-- `Result' is INTEGER constant named `app_max_height'.
		do
			Result := app_max_height_cell.item
		end

	app_max_height_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `app_max_height'.
		once
			create Result.put (2000)
		end

	border_width: INTEGER
			-- `Result' is INTEGER constant named `border_width'.
		do
			Result := border_width_cell.item
		end

	border_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `border_width'.
		once
			create Result.put (4)
		end

	app_initial_width: INTEGER
			-- `Result' is INTEGER constant named `app_initial_width'.
		do
			Result := app_initial_width_cell.item
		end

	app_initial_width_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `app_initial_width'.
		once
			create Result.put (1024)
		end

	app_initial_x_position: INTEGER
			-- `Result' is INTEGER constant named `app_initial_x_position'.
		do
			Result := app_initial_x_position_cell.item
		end

	app_initial_x_position_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `app_initial_x_position'.
		once
			create Result.put (10)
		end

	app_initial_y_position: INTEGER
			-- `Result' is INTEGER constant named `app_initial_y_position'.
		do
			Result := app_initial_y_position_cell.item
		end

	app_initial_y_position_cell: CELL [INTEGER]
			--`Result' is once access to a cell holding vale of `app_initial_y_position'.
		once
			create Result.put (10)
		end

feature -- Access


	constants_initialized: BOOLEAN
			-- Have constants been initialized from file?
		do
			Result := initialized_cell.item
		end

	string_constant_by_name (a_name: STRING): STRING
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		do
			Result := (all_constants.item (a_name)).twin
		ensure
			Result_not_void: Result /= Void
		end
		
	integer_constant_by_name (a_name: STRING): INTEGER
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		local
			l_string: STRING
		do
			l_string := (all_constants.item (a_name)).twin
			check
				is_integer: l_string.is_integer
			end
			
			Result := l_string.to_integer
		end
		
	has_constant (a_name: STRING): BOOLEAN
			-- Does constant `a_name' exist?
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
		do
			Result := all_constants.item (a_name) /= Void
		end

feature {NONE} -- Implementation

	initialized_cell: CELL [BOOLEAN]
			-- A cell to hold whether the constants have been loaded.
		once
			create Result.put (False)
		end
		
	all_constants: HASH_TABLE [STRING, STRING]
			-- All constants loaded from constants file.
		once
			create Result.make (4)
		end
		
	file_name: STRING
			-- File name from which constants must be loaded.
		do
			Result := file_name_cell.item
		end
		
	file_name_cell: CELL [STRING]
		once
			create Result.put ("constants.txt")
		end
		
	set_file_name (a_file_name: STRING)
			-- Assign `a_file_name' to `file_name'.
		do
			file_name_cell.put (a_file_name)
		end
		
	String_constant: STRING = "STRING"
	
	Integer_constant: STRING = "INTEGER"
		
	parse_file_contents (content: STRING)
			-- Parse contents of `content' into `all_constants'.
		local
			line_contents: STRING
			is_string: BOOLEAN
			is_integer: BOOLEAN
			start_quote1, end_quote1, start_quote2, end_quote2: INTEGER
			name, value: STRING
		do
			from
			until
				content.is_equal ("")
			loop
				line_contents := first_line (content)
				if line_contents.count /= 1 then
					is_string := line_contents.substring_index (String_constant, 1) /= 0
					is_integer := line_contents.substring_index (Integer_constant, 1) /= 0
					if is_string or is_integer then
						start_quote1 := line_contents.index_of ('"', 1)
						end_quote1 := line_contents.index_of ('"', start_quote1 + 1)
						start_quote2 := line_contents.index_of ('"', end_quote1 + 1)
						end_quote2 := line_contents.index_of ('"', start_quote2 + 1)
						name := line_contents.substring (start_quote1 + 1, end_quote1 - 1)
						value := line_contents.substring (start_quote2 + 1, end_quote2 - 1)
						all_constants.force (value, name)
					end
				end
			end
		end
		
	first_line (content: STRING): STRING
			-- `Result' is first line of `Content',
			-- which will be stripped from `content'.
		require
			content_not_void: content /= Void
			content_not_empty: not content.is_empty
		local
			new_line_index: INTEGER		
		do
			new_line_index := content.index_of ('%N', 1)
			if new_line_index /= 0 then
				Result := content.substring (1, new_line_index)
				content.keep_tail (content.count - new_line_index)
			else
				Result := content.twin
				content.keep_head (0)
			end
		ensure
			Result_not_void: Result /= Void
			no_characters_lost: old content.count = Result.count + content.count
		end

	set_with_named_file (a_pixmap: EV_PIXMAP; a_file_name: STRING)
			-- Set image of `a_pixmap' from file, `a_file_name'.
			-- If `a_file_name' does not exist, do nothing.
		require
			a_pixmap_not_void: a_pixmap /= Void
			a_file_name /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			if l_file.exists then
				a_pixmap.set_with_named_file (a_file_name)
			end
		end

invariant
	all_constants_not_void: all_constants /= Void

end
