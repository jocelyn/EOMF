note
	component:   "openEHR Archetype Project"
	description: "[
				 OK and Cancel buttons, with left hand padding cell, to add to any dialog box.
				 ]"
	keywords:    "UI, ADL"
	author:      "Thomas Beale <thomas.beale@OceanInformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2012- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "See notice at bottom of class"

class EVX_OK_CANCEL_CONTROLS

inherit
	EVX_DEFINITIONS
		export
			{NONE} all;
			{ANY} deep_twin, is_deep_equal, standard_is_equal
		end

	SHARED_MESSAGE_DB
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make (ok_agent, cancel_agent: PROCEDURE [ANY, TUPLE])
		do
			create ev_root_container
			ev_root_container.set_padding_width (default_padding_width)
			ev_root_container.set_border_width (default_border_width)

			-- Padding Cell
			create ev_cell
			ev_root_container.extend (ev_cell)
			ev_cell.set_minimum_width (100)

			-- OK button
			create ok_button
			ok_button.set_text (get_text (ec_ok_button_text))
			ok_button.set_minimum_width (100)
			ok_button.set_minimum_height (26)
			ev_root_container.extend (ok_button)
			ev_root_container.disable_item_expand (ok_button)
			ok_button.select_actions.extend (ok_agent)

			-- Cancel button
			create cancel_button
			cancel_button.set_text (get_text (ec_cancel_button_text))
			cancel_button.set_minimum_width (100)
			cancel_button.set_minimum_height (26)
			ev_root_container.extend (cancel_button)
			ev_root_container.disable_item_expand (cancel_button)
			cancel_button.select_actions.extend (cancel_agent)
		end

feature -- Access

	ev_root_container: EV_HORIZONTAL_BOX

	ok_button, cancel_button: EV_BUTTON

feature -- Status Report

	has_button (a_title: STRING): BOOLEAN
			-- is there any button with title `a_title'?
		do
			Result := attached added_buttons and then
				(added_buttons.has(a_title) or a_title.same_string (ok_button.text) or a_title.same_string (cancel_button.text))
		end

feature -- Modification

	add_button (a_title: STRING; an_agent: PROCEDURE [ANY, TUPLE])
			-- add another button, which will appear to the left of the OK/Cancel buttons
		require
			not has_button (a_title)
		local
			a_button: EV_BUTTON
		do
			if not attached added_buttons then
				create added_buttons.make (0)
			end
			create a_button
			a_button.set_text (a_title)
			a_button.select_actions.extend (an_agent)
			added_buttons.put (a_button, a_title)
			ev_root_container.start
			ev_root_container.put_right (a_button)
			ev_root_container.disable_item_expand (a_button)
		end

feature -- Command

	enable_sensitive
			-- enable user input
		do
			cancel_button.enable_sensitive
			ok_button.enable_sensitive
		end

	disable_sensitive
			-- disable user input
		do
			cancel_button.disable_sensitive
			ok_button.disable_sensitive
		end

feature {NONE} -- Implementation

	ev_cell: EV_CELL

	added_buttons: detachable HASH_TABLE [EV_BUTTON, STRING]

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
--| The Original Code is gui_hash_table.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2012
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