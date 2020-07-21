# Description of the SyncServer and FloeNavi App features

Note: The offline version of this document does not have pictures included.

1. [Initial grid configuration](#initial-grid)
1. [Grid and station status messages](#status-messages)
1. [Pin for admin and special security access](#pin)
1. [Support for map images in the grid background](#map)
1. [Deletion of a grid on the sync server](#delete-grid)
1. [Synchronising additional base stations](#basestations-sync)
1. [Logging and Logfiles](#logging)
1. [Device operations export flags](#operations-flags)
1. [Deletion of device information](#delete-information)

### App: Initial grid configuration {#initial-gird}

To use the FloeNavi app, a grid needs to be configured by initially providing the MMSI of two stations:
- the origin station, which will become the origin of the grid, 
  defining the position `x=0.0m, y=0.0m` on the grid
- the x-axis station, which will have the role to define 
  the bearing of the x-axis of the grid. 
  On the grid it will be located somewhere along the x-axis, with `y=0.0m`, and the `x`-value 
  computed at each update.
  
The x-value of the x-axis-station is the distance of the x-axis station from the origin station.
Currently, the distance is only required to render the background map image.

#### Admin view - Initial grid configuration

The grid is configured by opening the initial grid configuration view on the admin dashboard.

For nominal operation, a grid is configured by providing the MMSI of the origin station and the MMSI of the x-axis station.

- The configuration of a grid does not require a connection to the AIS-Transponder.
- It is not possible to configure a new grid, unless the old grid is deleted in the app.
- Any MMSI can be configured as the origin or x-axis station MMSI

If, at some time in the past, valid positional data was received from a station, the station MMSI
will appear in the MMSI selection list. This list is updated approximately every 15s.

The configuration view itself will also show if there is recent positional data received 
from the selected station, displayed in the lower half of the screen as LAT/LON values.

However, the admin may decide to accept the configuration at any time, 
even if a station has not yet sent any data.

By confirming the configuration, the grid is considered to be **CONFIGURED**.
The app will start the **INITIALIZATION** in the background, and the grid status icon will
reflect the state of the grid.

**Notes:**
- In addition to the initial grid configuration, a grid can be downloaded to the app from the sync server using the sync view
  - if there is currently no grid configured in the. In this case the grid in the app needs to be deleted
- If a grid is downloaded from the sync server, it will also start in the initialization phase

##### The initializiation phase

Instead of a one-time initialization phase at the time of grid configuration, the grid is using a time-window
based grid quality estimation.

- For release v3.1, a time window of 30min was defined, 
in which for each base station at least 4 valid AIS messages had to be received,
for the grid to be considered GREEN (stable).

- After receiving feedback for release v3.1, 
  the time-window was changed to 10min and 1 valid AIS message.

Every time a grid interaction is triggered, i.e. receiving an AIS message with positional/movement data,
the grid quality (or accuracy) is measured. Based on the timeliness and content of the messages, the
status icon is changed.

However, the grid will try keep positions, bearings and drift of the grid and registered stations as
accurate as possible, based on the information that is available.

#### Grid status icon

**Notes:**

- When starting the app, the grid status icon will always be red.
- The status icon shows the **current** state of the grid, 
  it is an indicator for the quality of the data used to compute position, 
  bearings and drift of the grid and registered stations on the grid.
- A station that is not sending COG or SOG is considered to be offline.

The following color indicator are supported by the status icon:

- RED:
  - the grid is not yet configured
  - the grid has not received valid data for enough base station on the grid within 10min.
  - the grid is **LOST**, i.e. it will not follow the drift and stations may jump with each update

- YELLOW:
  - the grid has not received valid data for each base station on the grid within 10min, but it has
    enough data to reliable compute a grid from data that was received within 10min, i.e. because additional stations have been added.
  - the grid is **DEGRADED**
  - It is dangerous to remove stations from the grid in this state.
    
- GREEN:
  - the grid has received valid data for each base station (origin, x-axis and additional) within 10 min.
  
##### What is a valid AIS message

The AIS protocol allows for the fields in the messages to be marked as **invalid** or **unavailable**.

- A value of 360.0 degrees for the course over ground value (COG)
- A value of 102.3 knots for the speed over ground value (SOG)
- A value of 0x6791AC0 (181°) for longitude (LON)
- A value of 0x3412140 (91°) for latitude (LAT)

For the estimation of the quality of the grid, a station that is sending positional data (LAT/LON),
but not COG/SOG will be considered **OFFLINE**.

- In v3.2, a station that is not sending COG/SOG data, will generate **LOST** messages.

Even though the COG/SOG data is not available, the grid can be computed to a certain accuracy
with just the positional data (LAT/LON).

The grid will also try to display these positions anyway, as they are **mostly** accurate for a short time
after receiving the position data, but they will drift away from their **real** position quickly. This
is also indicated by a RED grid icon (v3.2).
 
- Typically, COG is not available if SOG is below 0.4kn (0.2m/s).
- For computation, COG and SOG is assumed to be 0 if one of the two values is not available. 
  Otherwise, always assuming a course of e.g 360° would further increase the inaccuracy.
- Typically, the expected error is approx. 36m after 3min.

For release v3.1, AIS-values were used as they were received, ie. COG of 360.0° was used in the grid calculation.
This could increase the error in positional accuracy to larger than 72m after 3min.

##### Advanced Topic: Details of the grid quality utility function

- A basic score/point system is used to measure the quality of a grid.
  - the origin station provides 200 points
  - the x-axis station provides 100 points
  - each additional station provides 100 points
  
- The expected score is based on the synchronized grid configuration, which is also stored at the sync server.
- The measured score is based on a communication monitor in the app that records a timestamp for the messages received from each station.

- If the measured score is equal to the expected score, the grid icon is colored GREEN.
- If the measured score is below 300 points, the grid is colored RED.
- If the measured score is above 300 points, but below the expected score, the grid icon is colored YELLOW. 
  This is called **DEGRADED**, as there is enough information to compute a grid, but not with data from all configured stations.

The score of 300 can be reached by configuring
- an origin station and a x-axis station (300 points)
- an origin station, x-axis-station and one additional base station (400 points)
- ...

**Notes:**
- To add additional stations, the grid needs to be setup with origin and x-axis station. For triangulation,
  the initial X/Y-position of the additional stations need to be recorded when these are added to the grid.
- The app will deny the "base station recovery" action, if the score would fall below 300 points.  
- Not all possible scenarios can be synchronized with the sync server
- Not all possible scenarios are supported by the grid prediction algorithm
  
**Example**

_Setting up a nominal grid_
- Origin station: 200 points
- X-Axis station: 100 points

This is most basic valid configuration, because the configuration provides 300 points. 
Initially, the grid icon is RED.
A few of the possible scenarios:
- If the grid has received valid data for the origin station,
  and now receives a valid datum for the x-axis station, 
  the color of the grid icon is set GREEN.
- If the grid has received a valid datum for the x-axis station, 
  but the communication monitor has not recorded
  a valid datum from the origin station within the last 10min, 
  the color of the grid icon is set RED.

The grid is updated in both cases, and will display the stations and icons.
However, the accuracy of the computation degrades with the age of the last valid message, as the
position of a station is predicted based on the last received LAT/LON and COG/SOG values.


_Adding a base station to the grid_
- Additional Station S1: 100 points

The configuration now provides 400 points. Initially, the grid icon is RED.
A few of the possible scenarios:
- If the grid has received valid data for the origin station, 
  and now receives a valid datum for the x-axis station, 
  the color of the grid icon is set YELLOW.
  The grid is fully functional, but there is no data for station S1.
- If the grid has received valid data for the origin and x-axis station, 
  and now receives a valid datum for the additional station S1, 
  the color of the grid icon is set GREEN.
- If the grid now receives a valid datum for the origin station,
  but the last recorded message for the x-axis station has been 15min ago
  and the last recorded message for station S1 has been 10s ago,
  the grid icon is set YELLOW.
  Since the data for station S1 is more current than the x-axis station, 
  the grid bearing is reconstructed from the last recorded bearing between origin and S1 and the
  X/Y-position of S1 on the grid.


### Grid and station messages {#status-messages}

The grid algorithm and communication monitor will emit **ALERTS** that are displayed in the grid view.
Such an alert can be triggered by any update to the grid algorithm, 
i.e. any message received from the AIS transponder, or a scheduled grid re-calculation request
to update the grid view and icon positions.

#### Station LOST

`No data received from AIS Station xxxxxxxxx since xxxxx seconds`

The grid algorithm has detected, that a station has not sent any communication since 10min.
This station is than marked as offline and will no longer be displayed on the grid until
a new message is received.


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

### Logging and Logfiles {#logging}

#### SyncServer audit log
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

#### SyncServer tablet log

Every time a tablet is synchronized with the SyncServer, the tablet will transfer up to 10MB
of the latest recorded log messages to the SyncServer.

For each tablet a dedicated folder will be created on the SyncServer that will hold these files.

The files are plain text files with timestamped messages, 
which can easily be split into smaller parts and
compressed with ZIP or 7-Zip with a high compression ratio.

The following list contain messages indicating typical issues.

##### Connection issues

- The tablet is on a network where a machine 192.168.0.1 is available, but is not responding to requests on port 2000:
```
AisServiceRunnable: java.net.ConnectException: failed to connect to /192.168.0.1 (port 2000) after 2500ms: isConnected failed: ECONNREFUSED (Connection 
refused)
```

- The tablet is not connected to a network, or connected to a local (un-routed) network without access to 192.168.0.1:
```
AisServiceRunnable: java.net.ConnectException: failed to connect to /192.168.0.1 (port 2000) after 2500ms: connect failed: ENETUNREACH (Network is unreachable)
```

- The tablet has not received any messages on the connection to the AIS transponder located at 192.168.0.1 for 30s:
```
AisServiceRunnable: java.net.SocketTimeoutException
```

- The connection to the SyncServer failed:
```
SynchronisationViewModel: java.lang.RuntimeException: java.net.ConnectException: Failed to connect to /10.0.2.2:8080
```

##### Received AIS messages

- A **good** message
  - This transponder probably connects to a compass and log, and does not use GPS for speed and course
```
AisServiceRunnable: Received line: !AIVDM,1,1,,B,139KSs0v@00eWWjN`;A`D8NN00RB,0*24
AisServiceRunnable: Decoded geo info mmsi: 211215340, position: (lat:53.5258766667 lon:9.9656416667), movement: (sog:0.0 cog:212.8)
```

- A message missing COG and SOG
```
AisServiceRunnable: Received line: !AIVDM,1,1,,A,139a8jPP010eU=JN`p8>4?vL0<3g,0*69
AisServiceRunnable: Decoded geo info mmsi: 211437770, position: (lat:53.5450133333 lon:9.9574083333), movement: (sog:null cog:null)
```

- A message missing LAT/LON and COG and SOG
```
Received line: !AIVDO,1,1,,,B39>ab03wk?8mP=18D3Q3wwQhP00,0*7D
Decoded geo info mmsi: 211003816, position: (lat:91.0 lon:181.0), movement: (sog:null cog:null)
```

- A **good** message containing voyage data (vessel name)
```
AisServiceRunnable: Received line: !AIVDM,2,1,2,B,539q8nT00000@SO37<0<58j0HD@@E9<Dp000001S1`42240Ht00000000000,0*10
AisServiceRunnable: Decoded name info mmsi: 211699930, name: CARL FEDDERSEN
```

- Some messages cannot be decoded, but this should not be an issue
  - This seems to be a AIS transponder housekeeping message
```
AisServiceRunnable: Received line: $AIALR,083852,002,A,V,AIS: Antenna VSWR exceeds limit*78
AisServiceRunnable: de.awi.floenavi.ais.decoder.AISDecoderException: Message TalkerID is not an AIVDM/AIVDO id, must start with '!': $AIALR

AisServiceRunnable: Received line: $AIALR,100002,007,A,V,AIS: UTC sync invalid*2D
AisServiceRunnable: de.awi.floenavi.ais.decoder.AISDecoderException: Message TalkerID is not an AIVDM/AIVDO id, must start with '!': $AIALR

AisServiceRunnable: Received line: $AIALR,100003,026,A,V,AIS: no position sensor in use*71
AisServiceRunnable: de.awi.floenavi.ais.decoder.AISDecoderException: Message TalkerID is not an AIVDM/AIVDO id, must start with '!': $AIALR

AisServiceRunnable: Received line: $AIALR,100003,029,A,V,AIS: no valid SOG information*74
AisServiceRunnable: de.awi.floenavi.ais.decoder.AISDecoderException: Message TalkerID is not an AIVDM/AIVDO id, must start with '!': $AIALR
```

##### Grid algorithm



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

