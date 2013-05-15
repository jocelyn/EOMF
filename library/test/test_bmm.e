note
	component:   "openEHR Archetype Project"
	description: "Shared UI resources"
	keywords:    "test, ADL"
	author:      "Thomas Beale <thomas.beale@OceanInformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2009- Ocean Informatics Pty Ltd <http://www.oceaninfomatics.com>"
	license:     "See notice at bottom of class"
	testing:     "type/manual"

class
	TEST_BMM

inherit
	TEST_UTILITIES
		redefine
			on_prepare
		end

	SHARED_REFERENCE_MODEL_ACCESS
		undefine
			default_create
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			app_root.initialise_shell
			if app_root.ready_to_initialise_app then
				app_root.initialise_app
				assert ("No RM schemas", rm_schemas_access.found_valid_schemas)
				rm_schema := rm_schemas_access.schema_for_rm_closure ("openehr-ehr")
			end
		end

feature -- Access

	rm_schema: detachable BMM_SCHEMA
			-- set if this archetype has a valid package-class_name
		note
			option: stable
		attribute
		end

feature -- Test routines

	test_has_property_path
			-- New test routine
		note
			testing:  "paths", "bmm", "covers/{SCHEMA_ACCESS}.has_property_path"
		do
			assert ("CARE_ENTRY has /protocol", rm_schema.has_property_path ("CARE_ENTRY", "/protocol"))
			assert ("CARE_ENTRY has /data/events/data", rm_schema.has_property_path ("CARE_ENTRY", "/data/events/data"))
			assert ("OBSERVATION has /data/events/data", rm_schema.has_property_path ("OBSERVATION", "/data/events/data"))
			assert ("OBSERVATION has /data/events/data/items", rm_schema.has_property_path ("OBSERVATION", "/data/events/data/items"))
			assert ("OBSERVATION has /data/events[at0003]/math_function", rm_schema.has_property_path ("OBSERVATION", "/data/events[at0003]/math_function"))
			assert ("OBSERVATION has /protocol", rm_schema.has_property_path ("OBSERVATION", "/protocol"))
			assert ("OBSERVATION has /data/events[at0002]/data/items[at0.76]/items", rm_schema.has_property_path ("OBSERVATION", "/data/events[at0002]/data/items[at0.76]/items"))
			assert ("OBSERVATION not has /data/events[at0002]/data/itemsXX[at0.76]/items", not rm_schema.has_property_path ("OBSERVATION", "/data/events[at0002]/data/itemsXX[at0.76]/items"))
			assert ("COMPOSITION not has /xxxx", not rm_schema.has_property_path ("COMPOSITION", "/xxxx"))
			assert ("CLUSTER has /items/items/items", rm_schema.has_property_path ("CLUSTER", "/items/items/items"))
		end

	test_property_definition_at_path
			-- New test routine
		note
			testing:  "paths", "bmm", "covers/{SCHEMA_ACCESS}.property_definition_at_path"
		do
			assert ("CARE_ENTRY found property at /protocol", rm_schema.property_definition_at_path ("CARE_ENTRY", "/protocol").name.is_equal("protocol"))
			assert ("CARE_ENTRY found property at /data/events/data", rm_schema.property_definition_at_path ("CARE_ENTRY", "/data/events/data").name.is_equal("data"))
			assert ("OBSERVATION found property at /data/events/data", rm_schema.property_definition_at_path ("OBSERVATION", "/data/events/data").name.is_equal("data"))
			assert ("OBSERVATION found property at /data/events/data/items", rm_schema.property_definition_at_path ("OBSERVATION", "/data/events/data/items").name.is_equal("items"))
			assert ("OBSERVATION found property at /data/events[at0003]/math_function", rm_schema.property_definition_at_path ("OBSERVATION", "/data/events[at0003]/math_function").name.is_equal("math_function"))
			assert ("OBSERVATION found property at /protocol", rm_schema.property_definition_at_path ("OBSERVATION", "/protocol").name.is_equal("protocol"))
			assert ("OBSERVATION found property at /data/events[at0002]/data/items[at0.76]/items", rm_schema.property_definition_at_path ("OBSERVATION", "/data/events[at0002]/data/items[at0.76]/items").name.is_equal("items"))
			assert ("CLUSTER found proerty at /items/items/items", rm_schema.property_definition_at_path ("CLUSTER", "/items/items/items").name.is_equal("items"))
		end

	test_is_descendant_of
			-- New test routine
		note
			testing:  "is_descendant_of", "bmm", "covers/{BMM_SCHEMA}.is_descendant_of"
		do
			assert ("COMPOSITION is a subclass of LOCATABLE", rm_schema.is_descendant_of ("COMPOSITION", "LOCATABLE"))
			assert ("LOCATABLE is not subclass of COMPOSITION", not rm_schema.is_descendant_of ("LOCATABLE", "COMPOSITION"))
			assert ("ITEM_STRUCTURE is subclass of LOCATABLE", rm_schema.is_descendant_of ("ITEM_STRUCTURE", "LOCATABLE"))
		end

	test_type_name_conforms_to
			-- New test routine
		note
			testing:  "type_name_conforms_to", "bmm", "covers/{BMM_SCHEMA}.type_name_conforms_to"
		do
			assert ("COMPOSITION conforms to LOCATABLE", rm_schema.type_name_conforms_to ("COMPOSITION", "LOCATABLE"))
			assert ("LOCATABLE conforms to COMPOSITION", not rm_schema.type_name_conforms_to ("LOCATABLE", "COMPOSITION"))
			assert ("ITEM_STRUCTURE <T> conforms to LOCATABLE", rm_schema.type_name_conforms_to ("ITEM_STRUCTURE <T>", "LOCATABLE"))
			assert ("EVENT <ITEM_STRUCTURE> conforms to LOCATABLE", rm_schema.type_name_conforms_to ("EVENT <ITEM_STRUCTURE>", "LOCATABLE"))
			assert ("List <ITEM_TREE> conforms to List <ITEM_STRUCTURE>", rm_schema.type_name_conforms_to ("List <ITEM_TREE>", "List <ITEM_STRUCTURE>"))
			assert ("List <ITEM_STRUCTURE> conforms to List <ITEM_TREE>", not rm_schema.type_name_conforms_to ("List <ITEM_STRUCTURE>", "List <ITEM_TREE>"))
		end

	test_immediate_suppliers
			-- New test routine
		note
			testing:  "immediate_suppliers", "bmm", "covers/{BMM_CLASS_DEFINITION}.immediate_suppliers"
		local
			supps: ARRAYED_SET [STRING]
		do
			supps := rm_schema.class_definition ("COMPOSITION").suppliers
			assert ("COMPOSITION immediate suppliers includes CODE_PHRASE", supps.has ("CODE_PHRASE"))
			assert ("COMPOSITION immediate suppliers includes DV_CODED_TEXT", supps.has ("DV_CODED_TEXT"))
			assert ("COMPOSITION immediate suppliers includes PARTY_PROXY", supps.has ("PARTY_PROXY"))
			assert ("COMPOSITION immediate suppliers includes EVENT_CONTEXT", supps.has ("EVENT_CONTEXT"))
			assert ("COMPOSITION immediate suppliers includes CONTENT_ITEM", supps.has ("CONTENT_ITEM"))
		end

	test_supplier_closure
			-- New test routine
		note
			testing:  "all_suppliers", "bmm", "covers/{BMM_CLASS_DEFINITION}.supplier_closure"
		local
			supps: ARRAYED_SET [STRING]
		do
			supps := rm_schema.class_definition ("COMPOSITION").supplier_closure
			assert ("COMPOSITION supplier closure includes CODE_PHRASE", supps.has ("CODE_PHRASE"))
			assert ("COMPOSITION supplier closure includes DV_CODED_TEXT", supps.has ("DV_CODED_TEXT"))
			assert ("COMPOSITION supplier closure includes PARTY_PROXY", supps.has ("PARTY_PROXY"))
			assert ("COMPOSITION supplier closure includes EVENT_CONTEXT", supps.has ("EVENT_CONTEXT"))
			assert ("COMPOSITION supplier closure includes CONTENT_ITEM", supps.has ("CONTENT_ITEM"))
			assert ("COMPOSITION supplier closure includes LINK", supps.has ("LINK"))
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
--| The Original Code is test_bmm.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2010
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
