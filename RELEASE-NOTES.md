# Release-Notes for v3.2.1

- The delivery of v3.2.1 package contains the following files
  - `FloeNavi-App-3.2.1.apk`: Full version of the app

## Changes in v3.2.1 since v3.2

### FloeNavi-App

- Grid not considered LOST (RED status icon) when stations do not provide COG/SOG. Grid is considered DEGRADED (YELLOW status icon) instead.
- Grid does no longer remove stations from the grid view that are only sending LAT/LON
- When updating the grid view between received AIS messages, stations that do not send COG/SOG are drawn at X/Y-positions established at time of message reception.
  
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

~~#### App: Invalid SOG and COG are ignored~~ (fixed in v3.2.1)

- ~~Stations that are not sending valid SOG and COG are not contributing to the
  grid drift calculation, therefore making the prediction of positions unreliable, 
  inside the 3m window between messages.~~
- ~~COG is typically not available for SOG below 0.4kn (0.2m/s).
  This will lead to estimated 36m difference between 
  predicted and actual position for a 3m window between messages.~~
- ~~When COG is not available, SOG and COG is assumed to be 0.~~
- ~~Stations visibly jump on the grid when a new message is received for a station~~

#### App: Additional base stations exponentially increase the complexity of the grid calculation

- Using 8 additional base stations on a simulated tablet 
  is the practical upper limit.
- Adding more stations above the limit will slow down the UI and increase battery usage

#### App: grid background map image only works when x-axis-station is part of the grid

- The map uses the distance between origin and x-axis station to calculate the scaling factor of the image.
- If there is no x-axis-station on the grid, the distance can not be calculated.
- The distance is only needed for the map background image, not for nominal grid operation. 
       
#### ~~App: Grid does not distinguish between invalid packages and lost stations~~ (fixed in v3.2.1)

- ~~The app will remove stations from the grid when they have not send any update for 10min~~
- ~~A station that is sending incomplete messages, i.e. SOG and COG values are unavailable, is also
  considered lost 10min after the last valid (including SOG/COG) message is received.~~
- ~~A station sending LAT/LON position will be displayed briefly on the grid, only to be removed
  with the next update (within 15s) if there was no SOG/COG in a message within the last 10min.~~
- ~~A incorrect LOST message is triggered with every update. The station is not lost, it is just not sending
  "useful" (complete) information.~~

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

