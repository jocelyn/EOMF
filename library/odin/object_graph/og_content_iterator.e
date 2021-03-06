note
	component:   "Eiffel Object Modelling Framework"
	description: "Tree iterator for OG structures that deploys a visitor on the OG node content property."
	keywords:    "archetype, constraint, definition"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2005-2012 Ocean Informatics Pty Ltd"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"
	void_safe:	 "yes, dirty"

	file:        "$URL$"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class OG_CONTENT_ITERATOR

create
	make

feature -- Initialisation

	make (a_target: OG_OBJECT_NODE; a_visitor: ANY)
			-- create a new manager targetted to the parse tree `a_target'
		require
			Target_exists: a_target /= Void
			Visitor_exists: a_visitor /= Void
		do
			create tree_iterator.make (a_target)
			visitor := a_visitor
		end

feature -- Command

	do_all
			-- start the serialisation process; the result will be in `serialiser_output'
		do
			tree_iterator.do_all (agent node_enter_action (?,?), agent node_exit_action (?,?))
		end

feature {NONE} -- Implementation

	tree_iterator: OG_ITERATOR

	visitor: ANY

	node_enter_action (a_node: OG_ITEM; indent_level: INTEGER)
		require
			Node_exists: a_node /= Void
		do
			a_node.enter_subtree (visitor, indent_level)
		end

	node_exit_action (a_node: OG_ITEM; indent_level: INTEGER)
		require
			Node_exists: a_node /= Void
		do
			a_node.exit_subtree (visitor, indent_level)
		end

end


