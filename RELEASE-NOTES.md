# Release-Notes for v3.2

- The delivery of v3.2 package contains the following files
  - `FloeNavi-App-3.2.apk`: Full version of the app
  - `FloeNavi-SyncServer-Patch-2.2.0.zip`: Incremental update for the SyncServer
  
- The upgrade of the SyncServer requires an installed **SyncServer v3.1**.

## New Features in v3.2 since v3.1

### SyncServer

- Synchronizing of additional base stations
- DELETE operation for device information
- Support to store log files received from the tablets

### FloeNavi-App

- Synchronization of additional base stations
- Logging support

## New Features in v3.1 since v3

### SyncServer

- Export Device Operations
  - Support for Flag: EXPORTED, PENDING, EXCLUDED

- Issues resolved
  - CSV fields filtered for **newline** characters
  - Device Operations only exported once
  - CSV timestamp adjusted to reflect non-standard datetime format requirements
  
### FloeNavi-App

- Issues resolved
  - Removing Origin-Station or X-Axis-Station no longer stops the App

## New Features in v3 since v1

### SyncServer

- Synchronisation
  - Logistical Installations
  - Grid Configuration
- Sending Configuration Information to the app
  - Admin PIN
  - Security PIN
  - Mothership MMSI
- Providing overlay map image and configuration for the app
  - Upload folder on SyncServer host
- Support for replacing the grid with a new grid from the app

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
- Creation/Logging
  - Logistical Installations
  - Device Operations with joined Logistical Installations
  - Waypoints
- Synchronisation
  - Logistical Installations
  - Device Information and Operations
  - Grid Origin and X-Axis Station
  - App Configuration (security configuration and mothership mmsi)
- Map support
  - Download of map from the SyncServer
  - Rotation and Scaling
  - Tracking map using origin and x-axis station
  
## Known issues

#### App & SyncServer: Logistical Installations Synchronisation which changes on the sync server and local modifications on the tablet
  - Setup: Observed when testing with two tablets
  - Note: Local changes on tablets do not get lost
  - A tablet that has local changes to the list of logistical installations, will upload
    upload the local changes but will never download the merged state from sync server.
  - If the state on the sync server changes again, 
    because of an update made by another tablets,
    both tablets will correctly download the state from the sync server.

#### App: Invalid SOG and COG are ignored
  - Stations that are not sending valid SOG and COG are not contributing to the
  grid drift calculation, therefore making the prediction of positions unreliable, 
  inside the 3m window between messages.
  - COG is typically not available for SOG below 0.4kn (0.2m/s).
  This will lead to estimated 36m difference between 
  predicted and actual position for a 3m window between messages.
  - When COG is not available, SOG and COG is assumed to be 0.
  - Stations visibly jump on the grid when a new message is received for a station

#### App: Additional base stations exponentially increase the complexity of the grid calculation

  - Using 8 additional base stations on a simulated tablet 
    is the practical upper limit.
  - Adding more stations above the limit will slow down the UI and increase battery usage

####  App: grid background map image only works when x-axis-station is part of the grid

  - The map uses the distance between origin and x-axis station to calculate the scaling factor of the image.
  - If there is no x-axis-station on the grid, the distance can not be calculated.
  - The distance is only needed for the map background image, not for nominal grid operation. 
       
### App

- ~~Removing origin or x-axis base station not working~~ (fixed in v3.1)
- ~~Number of synced elements not shown in App Sync View~~ (fixed in v3.2)
- ~~Additional grid base stations are not synced between tablets~~ (fixed in v3.2)
- App always downloads additional base stations from sync server, even if there were no changes

### SyncServer

- ~~No support for deleting device information~~ (fixedi n v3.2)
- ~~No support for tagging device operations "do not export" tag~~ (fixed in v3.1)
- ~~No extended logging of synchronisation elements~~ (fixed in v3.1)
- ~~No synchronisation of additional grid base stations~~ (fixed in v3.2)

