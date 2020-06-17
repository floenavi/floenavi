# Release-Notes for v3.1

- The delivery of v3.1 package contains the following files
  - `FloeNavi-App-3.1.apk`: Full version of the app
  - `FloeNavi-SyncServer-Patch-2.1.0.zip`: Incremental update for the SyncServer
  
- The upgrade of the SyncServer requires an installed **SyncServer v1**.

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

## Detailed Feature Description

### Map support (v3)

Displaying a map image in the app requires two files to be stored in a admin-defined
directory on the SyncServer host.
The directory used for providing those files is configured in the `application.yaml` file with the keyword `maps`

The example `application.yaml` is provided in the 
[upgrade instructions](https://github.com/floenavi/floenavi/blob/v3_1/UPGRADE.md)
and in the FloeNavi-Patch archive `etc`-folder.

#### 1. The map image file `map.jpg`

  - This must be a standard JPEG file.
The app was tested with a jpg of size 3353x1731 pixel and 4MB.
Images with 12Mpx (4000x3000) or higher should also be possible.
  - The position of the origin and x-axis station need to be manually locatable on the image.

![Example Map](https://github.com/floenavi/floenavi/raw/v3_1/map/map.jpg)

The origin stations is AIDAperla (red dot at Steinwerder Quay, right of center), 
the x-axis station is Europa2 (red dot at hamburg cruise center, center and top border).

#### 2. The image configuration file `map.info`

  - The pixel coordinates of the two stations need to be specified

Example content of the file:

```
origin 2300 681
x-axis 1774 201
```

  - origin is at x=2300, y=681
  - x-axis is at x=1774, y=201
  
The position `x=0`, `y=0` is the top-left corner of the image

#### 3. Disabling the map image

  - Remove the files from the map directory on the SyncServer
  - Perform a sync (download) from the SyncServer

If there is no image in the map directory on the SyncServer, the map image on the app will be deleted.

![Example Screenshot](https://github.com/floenavi/floenavi/raw/v3_1/map/map_screenshot.jpg)


### Grid Deletion (v3)

If there is a grid configured on the SyncServer, 
and the grid on the app has been deleted with the security pin and a new grid has been initialised, 
the SyncServer must be prepared to receive the new grid from the app.

A specific url has to be called on the server and the admin token has to be provided.

The following `curl` command can be used to reset the grid on the SyncServer:
```
curl -X DELETE -H "Authorization:  Bearer <token>" http://192.168.73.23/grid
```

`<token>` needs to be replaced by the `base64` encoded `adminToken` that is specified also in the
SyncServer `application.yaml` file.

The example `application.yaml` is provided in the 
[upgrade instructions](https://github.com/floenavi/floenavi/blob/v3_1/UPGRADE.md)
and in the FloeNavi-Patch archive `etc`-folder.

The encoded token for the default admin token is `MDEyMzQ1Njc4OWFiY2RlZg==`.

### Audit log (v3.1)

The SyncServer will write a message into a dedicated log file 
every time that elements are received or send.

The log file must be located in a directory on the SyncServer host.
The configuration of the log directory is done in the application.yaml file, with
the configuration option `logging->file->path`.

The example `application.yaml` is provided in the 
[upgrade instructions](https://github.com/floenavi/floenavi/blob/v3_1/UPGRADE.md)
and in the FloeNavi-Patch archive `etc`-folder.

**Note:**
- On Windows, the backslashes \ in the windows directory name 
need to be escaped as \\\\ when adding them to the configuration file.
- `C:\FloeNavi\Logs` needs to be written as `C:\\FloeNavi\\Logs`

### SyncServer export flags (v3.1)

To support the requirement of blocking device operations from export to the
DSHIP proxy system, the database table managing the device operations supports
now an additional field: `export_status` in table `operation`.

The allowed values for this field are: 
- `PENDING`: The device operation was synced from the tablet and is ready for export
- `EXCLUDED`: This device operation will not be exported
- `EXPORTED`: The device operation was retrieved by the DSHIP proxy and will not be exported again.

## Known issues

### App

- ~~Removing origin or x-axis base station not working~~ (fixed in v3.1)
- Number of synced elements not shown in App Sync View
- Additional grid base stations are not synced between tablets

### SyncServer

- No support for deleting device information
- ~~No support for tagging device operations "do not export" tag~~ (fixed in v3.1)
- ~~No extended logging of synchronisation elements~~ (fixed in v3.1)
- No synchronisation of additional grid base stations
