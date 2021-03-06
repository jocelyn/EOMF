## Eiffel Object Modelling Framework (EOMF)

EOMF is a holding project for various generic facilities for Eiffel applications, including:

* ODIN - Object Data Instance Notation - parser, validator, internal Data Tree representation, and serialiser for [ODIN notation](https://github.com/openEHR/odin). 

* BMM - Basic Meta-Model - an object schema representation facility. BMM schemas represent object data models, including classes and attributes with open and closed generics, inheritance etc. BMM files are written in ODIN syntax. [Examples](https://github.com/openEHR/reference-models/tree/master/models/openEHR/Release-1.0.2/BMM) used on openEHR.

* App resources - inheritable classes containing useful resources, like access to inline icons, standard app paths, etc.

* App config file, in ODIN format.

* [EVX](library/gui/evx) - layer over Eiffel Vision EV lib to provide higher level controls with built-in agents, visual settings.

* [ISO 8601 date/time library](library/app_support/date_time).

* [Error reporting objects](library/app_support/app_framework/error_reporting)

* [Message DB](apps/message_db) - Multi-lingual error message / UI text database facility; [example message sources and compiled output] (resources/messages).

* [Icon DB](apps/icon_db) - convert a directory of .ico / .png files to inline code for fast loading and fewer files for distribution; [example icon files and compiled output] (resources/icons).

Preferably, some of the App support and other minor classes would be replaced by either ISE Eiffel classes, gobo classes, or EiffelHub classes. These include:

* [EV_GRID enhancements](library/gui/vision2) that add keyboard and mouse support to EV_GRID, as well as cell-editing.

* A [FILE_REPOSITORY](library/app_support/file_system/file_repository.e) class that matches files on a file system.

* The [INTERVAL](library/app_support/basic/interval.e) class and the associated converter class [TYPE_UTILITIES](library/app_support/utility/misc/type_utilities.e).

* The [STRING_UTILITIES](library/app_support/utility/formatting/string_utilities.e) class.

* The [XML_TOOLS](library/app_support/utility/formatting/xml_tools.e) class.

* The [Error reporting](library/app_support/app_framework/error_reporting) classes.

* The [App Event Logging](library/app_support/app_framework/event_log) classes.

* The [SHARED_RESOURCES](library/app_support/app_framework/basic/shared_resources.e) class.

* [The Method dispatcher classes](library/app_support/method_dispatch).

* The Message DB and Icon DB tools above should be built into Eiffel Studio.

* The [vendor fixes](library/vendor-fixes/eiffel_software).

