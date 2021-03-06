note
	component:   "Eiffel Object Modelling Framework"
	description: "Visual control for a EV_GRID that adds basic app-level routines."
	keywords:    "UI, ADL"
	author:      "Thomas Beale <thomas.beale@OceanInformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2012- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class EVX_GRID

inherit
	STRING_UTILITIES
		export
			{NONE} all
		end

	EVX_DEFINITIONS
		export
			{NONE} all;
			{ANY} standard_is_equal, is_deep_equal, deep_copy, deep_twin
		end

create
	make

feature -- Initialisation

	make (enable_tree, row_height_fixed, col_resize_on_collapse_expand, hide_tree_node_connectors: BOOLEAN)
		do
			create ev_grid
			if enable_tree then
				ev_grid.enable_tree
				if hide_tree_node_connectors then
					ev_grid.hide_tree_node_connectors
				end
			end
			if not row_height_fixed then
				ev_grid.disable_row_height_fixed
			end
			if col_resize_on_collapse_expand then
				ev_grid.row_expand_actions.extend (agent (a_row: EV_GRID_ROW) do ev_grid.resize_columns_to_content (Default_grid_expansion_factor) end)
				ev_grid.row_collapse_actions.extend (agent  (a_row: EV_GRID_ROW) do ev_grid.resize_columns_to_content (Default_grid_expansion_factor) end)
			end
		end

feature -- Access

	ev_grid: EV_GRID_KBD_MOUSE

	last_row: detachable EV_GRID_ROW
			-- result of last successful call to `add_row' or `add_sub_row'

	row_count: INTEGER
		do
			Result := ev_grid.row_count
		end

	column_count: INTEGER
		do
			Result := ev_grid.column_count
		end

	matching_sub_row (a_parent_row: EV_GRID_ROW; a_row_test: FUNCTION [ANY, TUPLE [EV_GRID_ROW], BOOLEAN]): detachable EV_GRID_ROW
		local
			i: INTEGER
		do
			from i := 1 until i > a_parent_row.subrow_count or attached Result loop
				if a_row_test.item ([a_parent_row.subrow (i)]) then
					Result := a_parent_row.subrow (i)
				end
				i := i + 1
			end
		end

feature -- Status Report

	has_matching_sub_row (a_parent_row: EV_GRID_ROW; a_row_test: FUNCTION [ANY, TUPLE [EV_GRID_ROW], BOOLEAN]): BOOLEAN
		local
			i: INTEGER
		do
			from i := 1 until i > a_parent_row.subrow_count or a_row_test.item ([a_parent_row.subrow (i)]) loop
				i := i + 1
			end
			Result := i <= a_parent_row.subrow_count
		end

feature -- Modification

	set_tree_expand_collapse_icons (an_expand_icon, a_collapse_icon: EV_PIXMAP)
		do
			if ev_grid.is_tree_enabled then
				ev_grid.set_node_pixmaps (an_expand_icon, a_collapse_icon)
			end
		end

	add_row (a_data: detachable ANY)
		do
			ev_grid.insert_new_row (ev_grid.row_count + 1)
			last_row := ev_grid.row (ev_grid.row_count)
			if attached a_data then
				last_row.set_data (a_data)
			end
		end

	add_sub_row (a_parent_row: EV_GRID_ROW; a_data: detachable ANY)
		do
			a_parent_row.insert_subrow (a_parent_row.subrow_count + 1)
			last_row := a_parent_row.subrow (a_parent_row.subrow_count)
			if attached a_data then
				last_row.set_data (a_data)
			end
		end

	set_last_row (a_row: EV_GRID_ROW)
		do
			last_row := a_row
		end

	set_last_row_label_col (a_col: INTEGER; a_text, a_tooltip: detachable STRING; a_fg_colour: detachable EV_COLOR; a_pixmap: detachable EV_PIXMAP)
			-- add column details to `last_row'
		local
			gli: EV_GRID_LABEL_ITEM
		do
			if attached a_text then
				create gli.make_with_text (utf8_to_utf32 (a_text))
			else
				create gli.default_create
			end
			if attached a_fg_colour then
				gli.set_foreground_color (a_fg_colour)
			end
			if attached a_pixmap then
				gli.set_pixmap (a_pixmap)
			end
			if attached a_tooltip then
				gli.set_tooltip (utf8_to_utf32 (a_tooltip))
			end
			last_row.set_item (a_col, gli)
		end

	add_last_row_pointer_button_press_actions (a_col: INTEGER; an_action: PROCEDURE [ANY, TUPLE])
		do
			if attached {EV_GRID_LABEL_ITEM} last_row.item (a_col) as gli then
				gli.pointer_button_press_actions.force_extend (an_action)
			end
		end

	add_last_row_select_actions (a_col: INTEGER; an_action: PROCEDURE [ANY, TUPLE])
		do
			if attached {EV_GRID_LABEL_ITEM} last_row.item (a_col) as gli then
				gli.select_actions.force_extend (an_action)
			end
		end

	update_last_row_label_col (a_col: INTEGER; a_text, a_tooltip: detachable STRING; a_fg_colour: detachable EV_COLOR; a_pixmap: detachable EV_PIXMAP)
			-- update column details to `last_sub_row'; any detail that is Void is not changed in existing column
		do
			if attached {EV_GRID_LABEL_ITEM} last_row.item (a_col) as gli then
				if attached a_text then
					gli.set_text (utf8_to_utf32 (a_text))
				end
				if attached a_tooltip then
					gli.set_tooltip (utf8_to_utf32 (a_tooltip))
				end
				if attached a_fg_colour then
					gli.set_foreground_color (a_fg_colour)
				end
				if attached a_pixmap then
					gli.set_pixmap (a_pixmap)
				end
			end
		end

	set_last_row_label_col_multi_line (a_col: INTEGER; a_text, a_tooltip: detachable STRING; a_fg_colour: detachable EV_COLOR; a_pixmap: detachable EV_PIXMAP)
		do
			set_last_row_label_col (a_col, a_text, a_tooltip, a_fg_colour, a_pixmap)
			if attached {EV_GRID_LABEL_ITEM} last_row.item (a_col) as gli then
				last_row.set_height (gli.text_height + Default_grid_row_expansion)
			end
		end

	update_last_row_label_col_multi_line (a_col: INTEGER; a_text, a_tooltip: detachable STRING; a_fg_colour: detachable EV_COLOR; a_pixmap: detachable EV_PIXMAP)
			-- update column details to `last_sub_row'; any detail that is Void is not changed in existing column
		do
			if attached {EV_GRID_LABEL_ITEM} last_row.item (a_col) as gli then
				if attached a_text then
					gli.set_text (utf8_to_utf32 (a_text))
					last_row.set_height (gli.text_height + Default_grid_row_expansion)
				end
				if attached a_tooltip then
					gli.set_tooltip (utf8_to_utf32 (a_tooltip))
				end
				if attached a_fg_colour then
					gli.set_foreground_color (a_fg_colour)
				end
				if attached a_pixmap then
					gli.set_pixmap (a_pixmap)
				end
			end
		end

	last_row_add_checkbox (col: INTEGER)
			-- Add a checkbox column to `col' of a `last_row'
		local
			gcli: EV_GRID_CHECKABLE_LABEL_ITEM
		do
			create gcli
			last_row.set_item (col, gcli)
			gcli.set_is_checked (True)
			gcli.pointer_button_press_actions.force_extend (agent set_checkboxes_recursively (gcli))
		end

	remove_matching_sub_rows (a_parent_row: EV_GRID_ROW; a_row_test: FUNCTION [ANY, TUPLE [EV_GRID_ROW], BOOLEAN])
		local
			remove_list: SORTED_TWO_WAY_LIST [INTEGER]
			sub_row: EV_GRID_ROW
			i: INTEGER
		do
			create remove_list.make
			from i := 1 until i > a_parent_row.subrow_count loop
				sub_row := a_parent_row.subrow (i)
				if a_row_test.item ([sub_row]) then
					remove_list.extend (sub_row.index)
				end
				i := i + 1
			end
			from remove_list.finish	until remove_list.off loop
				ev_grid.remove_row (remove_list.item)
				remove_list.back
			end
		end

	remove_sub_rows (a_parent_row: EV_GRID_ROW)
		local
			i, c: INTEGER
		do
			c := a_parent_row.subrow_count
			from i := 1 until i > c loop
				ev_grid.remove_row (a_parent_row.subrow (1).index)
				i := i + 1
			end
		end

	set_column_titles (col_names: ARRAYED_LIST [STRING])
			-- set grid column titles
		local
			i: INTEGER
		do
			if ev_grid.row_count > 0 then
				from i := 1 until i > ev_grid.column_count.min (col_names.count) loop
					ev_grid.column (i).set_title (utf8_to_utf32 (col_names.i_th (i)))
					i := i + 1
				end
			end
		end

	hide_column (a_col: INTEGER)
		do
			if ev_grid.column_count >= a_col then
				ev_grid.hide_column (a_col)
			end
		end

	wipe_out
		do
			ev_grid.wipe_out
		end

feature -- Commands

	expand_tree
			-- expand entire tree, if there is content
		do
			if row_count > 0 then
				ev_grid.expand_tree (ev_grid.row (1), Void)
			end
		end

	collapse_tree
			-- expand entire tree, if there is content
		do
			if row_count > 0 then
				ev_grid.collapse_tree (ev_grid.row (1))
			end
		end

	resize_columns_to_content
		do
			ev_grid.resize_columns_to_content (Default_grid_expansion_factor)
		end

	set_checkboxes_recursively (a_gcli: EV_GRID_CHECKABLE_LABEL_ITEM)
			-- For all sub-items of `a_gcli', set their check boxes in the same column to match the parent's, recursively.
		local
			i: INTEGER
		do
			from i := a_gcli.row.subrow_count until i = 0 loop
				if attached {EV_GRID_CHECKABLE_LABEL_ITEM} a_gcli.row.subrow (i).item (a_gcli.column.index) as sub_gcli then
					sub_gcli.set_is_checked (a_gcli.is_checked)
					set_checkboxes_recursively (sub_gcli)
				end
				i := i - 1
			end
		end

end



