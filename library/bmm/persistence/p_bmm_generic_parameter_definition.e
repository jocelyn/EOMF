note
	component:   "Eiffel Object Modelling Framework"
	description: "Persistent form of BMM_GENERIC_PARAMETER_DEFINITION"
	keywords:    "Basic meta-model"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2011- The openEHR Foundation <http://www.openEHR.org>"
	license:     "Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>"

class P_BMM_GENERIC_PARAMETER_DEFINITION

inherit
	P_BMM_TYPE_SPECIFIER

feature -- Access (attributes from schema)

	name: STRING
			-- name of the parameter, e.g. 'T' etc
			-- DO NOT RENAME OR OTHERWISE CHANGE THIS ATTRIBUTE EXCEPT IN SYNC WITH RM SCHEMA
		attribute
			create Result.make_empty
		end

	conforms_to_type: detachable STRING
			-- optional conformance constraint
			-- DO NOT RENAME OR OTHERWISE CHANGE THIS ATTRIBUTE EXCEPT IN SYNC WITH RM SCHEMA

feature -- Access

	bmm_generic_parameter_definition: detachable BMM_GENERIC_PARAMETER_DEFINITION
		note
			option: transient
		attribute
		end

feature -- Factory

	create_bmm_generic_parameter_definition (a_bmm_schema: BMM_SCHEMA)
		do
			if attached conforms_to_type as conf_type and then attached a_bmm_schema.class_definition (conf_type) as class_def_conf_type then
				create bmm_generic_parameter_definition.make_constrained (name, class_def_conf_type, a_bmm_schema.any_class_definition)
			else
				create bmm_generic_parameter_definition.make (name, a_bmm_schema.any_class_definition)
			end
		end

end


