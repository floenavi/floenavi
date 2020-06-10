# Release-Notes for v3

- The delivery of v3 package contains the following files
  - `app-release.apk`: Full version of the app
  - `FloeNavi-SyncServer-Patch-2.0.0.zip`: Incremental update for the SyncServer
  
- The upgrade of the SyncServer requires an installed SyncServer v1.

## Features in v3

### SyncServer

- Synchronisation
  - Logistical Installations
  - Grid Configuration
  - Device Information and Operations
- Sending Configuration Information to the app
  - Admin PIN
  - Security PIN
  - Mothership MMSI
- Providing overlay map image and configuration for the app
- Support for overwriting the grid using a new grid from the app
  - Upload folder on SyncServer host

### FloeNavi-App

- Grid Configuration
  - Grid with Origin and X-Axis
  - Adding and removing additional base stations
- Grid View
  - Showing Logistical Installations
  - Displaying Waypoints
  - Tracking of Mobile Stations
  - Showing Base Stations (origin, x-axis and additional)
  - Shows Mothership
  - Zoom and Pan
  - Map image overlay
  - Waypoints, Logistical Installations and Base Stations can be hidden
  - Popup shows name, lat/lon and x/y of each icon
- Creation
  - Logistical Installations
  - Device Operations with joined Logistical Installations
  - Waypoints
- Synchronisation
  - Logistical Installations
  - Device Information and Operations
  - Grid Origin and X-Axis
- Map support
  - Download of map from the SyncServer
  - Rotation and Scaling
  - Tracking map using origin and x-axis station


## Known issues

### App

- Removing origin or x-axis base station not working
- Number of synced elements not shown
- Additional base stations are not synced between tablets

### SyncServer

- No support for deleting device information
- No support for tagging device operations "do not export" tag
- No extended logging of synchronisation elements
- No synchronisation of additional grid base stations
