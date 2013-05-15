note
	component:   "openEHR Libraries"
	description: "[
				 Shared access to ODIN->XML conversion rules file access object. Inherit into application
				 root class only, and make the call set_xml_load_rules_agent.
				 ]"
	keywords:    "config, XML"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2011-2012 openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

class SHARED_XML_RULES_FILE_ACCESS

inherit
	SHARED_APP_RESOURCES

	SHARED_XML_RULES

feature -- Access

	xml_rules_cfg: CONFIG_FILE_ACCESS
			-- accessor object for application config file
		local
			p: STRING
		once
			if file_system.file_exists (xml_rules_file_path) then
				p := xml_rules_file_path
			else
				p := Default_xml_rules_file_path
			end
			create Result.make (create {ODIN_CONFIG_FILE_ACCESS}.make)
			Result.initialise (p)
		end

	xml_rules_load: detachable XML_RULES
			-- load rules or else create new
		do
			if attached {XML_RULES} xml_rules_cfg.object_value ("/", ({XML_RULES}).name) as x then
				Result := x
			end
		end

feature -- Commands

	set_xml_load_rules_agent
		do
			xml_load_rules_agent_cache.put (agent xml_rules_load)
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
--| The Original Code is shared_dadl_config_file_access.e.
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
