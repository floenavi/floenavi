# Description of the SyncServer and FloeNavi App features

Note: The offline version of this document does not have pictures included.

1. [Pin for admin and special security access](#pin)
1. [Support for map images in the grid background](#map)
1. [Deletion of a grid on the sync server](#delete-grid)
1. [Synchronising additional base stations](#basestations-sync)
1. [Logging and Logfiles](#logging)
1. [Device operations export flags](#operations-flags)
1. [Deletion of device information](#delete-information)


### SyncServer: Setting up admin and security PIN {#pin}

The admin view and grid deletion view are protected by two different 4-digit PIN codes.
The codes are configured on the SyncServer.

When syncing the tablet with the SyncServer, the PIN codes are updated in the FloeNavi app.

The example `application.yaml` is provided in the 
[upgrade instructions](https://github.com/floenavi/floenavi/blob/v3_2/UPGRADE.md)
and in the FloeNavi-Patch archive `etc`-folder.
 
**Note:**
- The initial PIN configured on the FloeNavi app, for both admin and security pin, is **0000**.
  
### Grid background map image support {#map}

Displaying a map image in the app requires two files to be stored in an admin-defined
directory on the SyncServer host.
The directory used for providing those files is configured in the `application.yaml` file with the keyword `maps`

The example `application.yaml` is provided in the 
[upgrade instructions](https://github.com/floenavi/floenavi/blob/v3_2/UPGRADE.md)
and in the FloeNavi-Patch archive `etc`-folder.

#### 1. The map image file `map.jpg`

- This must be a standard JPEG file.
- The app was tested with a jpg of size 3353x1731 pixel and 4MB.
Images with 12Mpx (4000x3000) or higher should also be possible.
- The position of the origin and x-axis station need to be manually locatable on the image.

![Example Map](https://github.com/floenavi/floenavi/raw/v3_2/map/map.jpg)

On the example map:
- The origin station is AIDAperla (red dot at Steinwerder Quay, right of center), 
- the x-axis station is Europa2 (red dot at hamburg cruise center, center and top border).

#### 2. The image configuration file `map.info`

  - The file contains the pixel coordinates of the two stations

For the example map:
```
origin 2300 681
x-axis 1774 201
```

- origin is at x=2300, y=681
- x-axis is at x=1774, y=201
  
The position `x=0`, `y=0` is the top-left corner of the image

#### 3. Removing the map image

  - Remove the files from the map directory on the SyncServer
  - Perform a sync (download) from the SyncServer

If there is no image in the map directory on the SyncServer, 
the map image on the app will be deleted.

![Example Screenshot](https://github.com/floenavi/floenavi/raw/v3_2/map/map_screenshot.jpg)


### Grid Deletion {#delete-grid}

If there is a grid configured on the SyncServer, 
and the grid on the app has been deleted with the security pin and a new grid has been initialised, 
the SyncServer must be prepared to receive the new grid from the app.

A specific url has to be called on the server and the admin token has to be provided.

The following `curl` command can be used to reset the grid on the SyncServer:
```
curl -X DELETE -H "Authorization:  Bearer <token>" http://localhost:8080/grid
```

`<token>` needs to be replaced by the `base64` encoded `adminToken` that is specified also in the
SyncServer `application.yaml` file.

The `base64` encoded token for the default admin token is `MDEyMzQ1Njc4OWFiY2RlZg==`.

The example `application.yaml` is provided in the 
[upgrade instructions](https://github.com/floenavi/floenavi/blob/v3_2/UPGRADE.md)
and in the FloeNavi-Patch archive `etc`-folder.

#### Encoding the admin token with base64 on Windows

The `certtool` provided by Windows can be used to encode text.
For this, the admin token needs to be saved in a file, i.e. `in.txt`.

The command `certtool -encode in.txt out.b64` will create the file `out.b64` with the
encoded content of `in.txt`

Newlines and linefeeds are encoded, too. Therefore care needs to be taken when creating the infile.

In the outfile, the encoded text will be wrapped
between the lines `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----`.

### Synchronization of additional base stations {#basestation-sync}

Modifications to an existing grid can only be performed from one tablet.
When a tablet is making changes to a grid, i.e. adding or removing base stations, 
these changes are first only recorded to the tablet.
The syncserver will accept one update to the additional base stations of a grid.

Any further modifications to the additional stations need to be authorized similar to the deletion of a grid.

```
curl -X DELETE -H "Authorization:  Bearer <token>" http://localhost:8080/grid/additional-stations
```

`<token>` needs to be replaced by the `base64` encoded `adminToken` that is specified also in the
SyncServer `application.yaml` file.

The `base64` encoded token for the default admin token is `MDEyMzQ1Njc4OWFiY2RlZg==`.

_Note:_

The authorization workflow is needed to not allow concurrent modifications of the grid.
Only allowing one source for modifications to the grid ensures that concurrent changes can not destroy the grid.
"Deleting" the additional stations does not destroy the existing grid.

### Audit log {#logging}

The SyncServer will write a message into a dedicated log file 
every time that elements are received or send.

The log file must be located in a directory on the SyncServer host.
The configuration of the log directory is done in the application.yaml file, with
the configuration option `logging->file->path`.

The example `application.yaml` is provided in the 
[upgrade instructions](https://github.com/floenavi/floenavi/blob/v3_2/UPGRADE.md)
and in the FloeNavi-Patch archive `etc`-folder.

**Note:**
- On Windows, the backslashes \ in the windows directory name 
need to be escaped as \\\\ when adding them to the configuration file.
- `C:\FloeNavi\Logs` needs to be written as `C:\\FloeNavi\\Logs`

### SyncServer export flags {#operations-flags}

To support the requirement of blocking device operations from export to the
DSHIP proxy system, the database table managing the device operations supports
now an additional field: `export_status` in table `operation`.

The allowed values for this field are: 
- `PENDING`: The device operation was synced from the tablet and is ready for export
- `EXCLUDED`: This device operation will not be exported
- `EXPORTED`: The device operation was retrieved by the DSHIP proxy and will not be exported again.

### Deleting device information {#delete-information}

Device information stored on the sync server can be deleted (flagged as `DELETED`),
and as such they are no longer visible in the FloeNavi app.

These device information do not get physically deleted from the database,
therefore the integrity of the database stays intact.

Using the device information update workflow, 
any device for which an update is received, will be undeleted.

