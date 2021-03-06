note
	component:   "Eiffel Object Modelling Framework"
	description: "interface class to ODIN parser and Data Tree"
	keywords:    "ODIN, data tree"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2003- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class ODIN_ENGINE

inherit
	PARSER_ENGINE
		redefine
			tree, parser
		end

	SHARED_DT_SERIALISERS
		export
			{NONE} all;
			{ANY} deep_copy, deep_twin, is_deep_equal, standard_is_equal, has_dt_serialiser_format
		end

create
	make

feature {NONE} -- Initialisation

	make
		do
			create parser.make
		end

feature -- Access

	tree: detachable DT_COMPLEX_OBJECT_NODE
			-- Set if parse succeeded.

feature -- Commands

	serialise (a_format: STRING; full_type_marking_on, output_typed_encapsulated: BOOLEAN)
			-- Serialise current artifact into `a_format'.
			-- `full_type_marking_on' = True if type marking even for inferrable primitive types should be added to serialised output
			-- `output_typed_encapsulated' = True: output with typed object wrapper, rather than just the series of attributes innside the object

		require
			Format_valid: has_dt_serialiser_format (a_format)
		local
			a_dt_iterator: DT_VISITOR_ITERATOR
		do
			if attached tree as att_tree and attached dt_serialiser_for_format (a_format) as a_dt_serialiser then
				a_dt_serialiser.reset
				if full_type_marking_on then
					a_dt_serialiser.set_full_type_marking_on
				end
				if output_typed_encapsulated then
					a_dt_serialiser.set_output_typed_encapsulated
				end
				create a_dt_iterator.make (att_tree, a_dt_serialiser)
				a_dt_iterator.do_all
				serialised := a_dt_serialiser.last_result
			else
				create serialised.make_empty
			end
		ensure
			serialised_attached: attached serialised
		end

feature {NONE} -- Implementation

	parser_execute
			-- call the parser.execute with specific args
		do
			if attached source as att_source then
				parser.execute (att_source, source_start_line)
			end
		end

	parser: ODIN_VALIDATOR
			-- ODIN parser.

end


