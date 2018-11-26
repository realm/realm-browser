3.0.1 Release notes (2017-11-03)
=============================================================
* Fix crash when deleting rows.
* Show the size of data properties in their cell.

3.0.0 Release notes (2017-10-16)
=============================================================
* Update to Realm 3.0.0.

2.1.12 Release notes (2017-07-27)
=============================================================
* Update to Realm 2.9.0 that fixes an issue connecting to multiple servers with the same user. 

2.1.11 Release notes (2017-07-17)
=============================================================
* Fix crash when import from CSV/XLSX
* Fix crash when deleting currently displayed array from another process
* Fix crash when open realm while Simulator startup

2.1.10 Release notes (2017-06-27)
=============================================================
* Improved user experience when connect to the Realm Object Server
* Hide internal realms from server browser window
* Adds an ability to add object links to lists

2.1.9 Release notes (2017-06-13)
=============================================================
* Fixed several issues related to opening and displaying synced realms after schema migration
* Fixed issue with logging out the user when working with multiple realms simultaneously

2.1.8 Release notes (2017-05-17)
=============================================================
* Fixed crash when opening realms from Object Server
* Fixed crash when searching for special characters
* Fixed C# model definitions export
* Save credentials when connecting to Object Server
* Object Server Browser window doesn’t close after opening realm

2.1.7 Release notes (2017-03-29)
=============================================================
* Updated to Realm 2.5 to support new file format
* Fixed the issue with selection when filter realms on Realm Object Server

2.1.6 Release notes (2017-03-02)
=============================================================
* Fixed an issue with token expiration for Realms opened from Realm Mobile Platform
* Stability improvements

2.1.5 Release notes (2017-02-10)
=============================================================
* Added the ability to save C# and JavaScript (@ksibod) model definitions
* Added an option to copy object's property value in context menu (@fergusean)
* Fixed compatibility issue with OS X 10.9
* Minor UI improvements

2.1.4 Release notes (2017-01-31)
=============================================================
* Updated to Realm 2.4.1 that fixes an authentication issue when working with synced Realms.

2.1.3 Release notes (2017-01-17)
=============================================================
* Fixed CSV export of synced realms
* Stability and performance improvements

2.1.2 Release notes (2016-12-09)
=============================================================
* Added the ability to filter Realms on Realm Object Server
* Improved error description if Realm file failed to open and for other errors
* Disabled editing values for primary key properties
* Fixed crash when removed object is being edited while table view reloading
* Fixed multiline text editing
* Fixed dates editing
* Fixed other UI issues

2.1.1 Release notes (2016-11-29)
=============================================================
* Added in-app crash reporting
* Added the ability to connect to Realm Object Server with admin username/password
* Improved property type detection when import from CSV files
* Fixed export to Compacted Realm
* Fixed crash related to sync metadata reset

2.0.1 Release notes (2016-10-06)
=============================================================
This release introduces support for the Realm Mobile Platform!
See <https://realm.io/news/introducing-realm-mobile-platform/> for an overview
of these great new features.

* Fixed opening encryped Realms 
* Fixed export to compressed Realm
* Fixed some UI issues

2.0.0 Release notes (2016-09-27)
=============================================================
This release introduces support for the Realm Mobile Platform!
See <https://realm.io/news/introducing-realm-mobile-platform/> for an overview
of these great new features.

* Support for Realm Mobile Platform
* Fixed export to CSV files

1.0.2 Release notes (2016-08-30)
=============================================================
* Updated Realm Browser app and file format icons to Realm's new look
* Adding support for optional fields (Java exporter)
* Improved Realm file discovery in "Open Common Location"
* Added the ability for multiple CSV file importing

0.103.1 Release notes (2016-05-20)
=============================================================
* Updated to Realm Objective-C 0.103.1
* UI layout and performance enhancements

0.102.1 Release notes (2016-05-17)
=============================================================
* Updated to Realm Objective-C 0.102.1

0.102.0 Release notes (2016-05-12)
=============================================================
* Updated to Realm Objective-C 0.102.0

0.100.0 Release notes (2016-05-02)
=============================================================
* Updated to Realm Objective-C 0.100.0
  * *(This fixes a bug where encrypted Realm files opened in the Browser would sometimes become corrupted.)*
* Fixed a crash in OS X Mavericks

0.98.6 Release notes (2016-03-29)
=============================================================
* Updated to Realm 0.98.6

0.98.5 Release notes (2016-03-15)
=============================================================
* Updated to Realm 0.98.5
* Added the ability to generate Swift model classes from a Realm file.
* Improvements to the Objective-C model generation, including generics and Realm's latest features.
* Improvements to the Java model generation, handling primary, indexed and required fields.
* Fixed a rendering issue involving properties in different objects that had the same name.

0.97.0 Release notes (2016-01-14)
=============================================================
* Updated to Realm to Objective-C 0.97.0.
* Improvements to the scrolling performance of the main table view in Realm documents.
* String-based searches in Realm files made non-case sensitive.
* Added 'Cut', 'Copy', 'Paste' and 'Select All' menu options, initially to make editing text values easier.
* Fixed an issue where editing properties in Realm objects weren't properly saving to disk.
* Added tooltip for boolean valued columns.
* Improved user experience when opening Ream files.

0.96.2 Release notes (2015-10-12)
=============================================================
Enhancements:
* Updated Realm to Objective-C 0.96.2
* Added a prompt to alert users about the mandatory format upgrade in Realm Objective-C 0.96.

Bug Fixes:
* Fixed an issue where the width of text fields wouldn't update when resizing columns in OS X El Capitan.

0.95.2 Release notes (2015-10-12)
=============================================================
Enhancements:
* Updated to Realm 0.95.2
* Add the ability to set child Realm objects in parent objects.
* Export compressed copies of Realm files.
* Open encrypted Realm files.

Bug Fixes:
* Update project for Xcode 7
* Fix several warnings when compiling in OS X 10.11
* Fixed a bug where object number badges were displaying incorrectly in OS X 10.11
* Added a Retina version of the "Lock" icon.

0.93.0 App Store Release Notes (2015-08-4)
=============================================================
Enhancements:
* OSX sandbox handling added to file read/write operations.
* New file format icon
