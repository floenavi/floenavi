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

## Detailed Feature Description

### Map support

Displaying a map image in the app requires two files to be stored in a admin-defined
directory on the SyncServer host.
The directory used for providing those files is configured in the `application.yaml` file with the keyword `maps`

The example `application.yaml` is provided in the [upgrade instructions](UPGRADE.md).

#### 1. The map image file `map.jpg`

  - This must be a standard JPEG file.
The app was tested with a jpg of size 3353x1731 pixel and 4MB.
Images with 12Mpx (4000x3000) or higher should also be possible.
  - The position of the origin and x-axis station need to be manually locatable on the image.

![Beispielkarte](https://github.com/floenavi/floenavi/raw/v3_0/map/map.jpg)

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

![Beispielkarte](https://github.com/floenavi/floenavi/raw/v3_0/map/map_screenshot.jpg)


### Grid Deletion

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

The example `application.yaml` is provided in the [upgrade instructions](https://github.com/floenavi/floenavi/blob/v3_0/UPGRADE.md).

The encoded token for the default admin token is `MDEyMzQ1Njc4OWFiY2RlZg==`.

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
