note
	component:   "Eiffel Object Modelling Framework"
	description: "[
				 Visual control for a LIST [STRING] data source that outputs to an EV_COMBO_BOX.
				 Visual control structure is a combo-box with a title.
				 Designed for selecting various values of a list or hash, not for editing. 
				 
								   Title
						+-------------------------+-+
						|                         |V|
						+-------------------------+-+
						
				 or
				 
							+-------------------------+-+
					Title	|                         |V|
							+-------------------------+-+

				 ]"
	keywords:    "UI, ADL"
	author:      "Thomas Beale <thomas.beale@OceanInformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2012 Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class EVX_COMBO_CONTROL

inherit
	EVX_TITLED_DATA_CONTROL
		rename
			make as make_data_control
		export
			{NONE} make_linked
		redefine
			data_source_agent
		end

create
	make

feature -- Initialisation

	make (a_title: STRING; a_data_source_agent: like data_source_agent;
			min_height, min_width: INTEGER; arrange_horizontally: BOOLEAN)
		do
			make_data_control (a_title, a_data_source_agent, min_height, min_width, arrange_horizontally)
			ev_data_control.select_actions.extend (agent propagate_select_action)
		end

feature -- Access

	ev_data_control: EV_COMBO_BOX

	data_source_agent: FUNCTION [ANY, TUPLE, detachable LIST [STRING]]

feature -- Commands

	clear
			-- Wipe out content
		do
			ev_data_control.wipe_out
		end

	populate
			-- Wipe out content.
		do
			ev_data_control.select_actions.block
			ev_data_control.wipe_out
			if attached {LIST [STRING]} data_source_agent.item ([]) as strs then
				strs.do_all (
					agent (str:STRING)
						do
							ev_data_control.extend (create {EV_LIST_ITEM}.make_with_text (utf8_to_utf32 (str)))
						end
				)
			end
			ev_data_control.select_actions.resume
		end

feature {NONE} -- Implementation

	propagate_select_action
		do
			if attached linked_data_controls then
				linked_data_controls.do_all (agent (a_ctl: EVX_DATA_CONTROL) do a_ctl.populate end)
			end
		end

feature {NONE} -- Implementation

	create_ev_data_control
		do
			create ev_data_control
		end

end



