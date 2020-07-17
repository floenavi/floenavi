# Upgrade from v3.1 to v3.2

This document describes the upgrade process to install
the incremental update from v3.1 to v3.2.

**Note:**

- SyncServer v3.1 must be installed on the SyncServer host

## 1. Preparing the Environment

1.1 **Stop the FloeNavi SyncServer**

   Press `Ctrl+C` in the console where the SyncServer is running. The SyncServer will shut down, and you'll get your 
   prompt back.
   
1.2 **Backup your database (optional but recommended)**
   Use the MySQL tools to create a backup of your database.
   

## 2. Patching the SyncServer directory

3. **Extract the patch archive**
   
Extract the patch archive `FloeNavi-SyncServer-Patch-2.2.0.zip` 
in a temporary directory of your choice.
   
4. **Copy files to the FloeNavi SyncServer installation**
   
Point the explorer to the directory where the FloeNavi SyncServer 
has been installed.
If the v1 installation instructions have been followed, 
the directory should be `C:\Program Files\FloeNavi`.
   
In the FloeNavi installation folder, 
there should be a subdirectory called `lib`.
    
Copy and Replace all files from the `lib` folder of the extracted patch
archive into the folder of the installed SyncServer.

The patch archive also contains a directory `etc` 
which contains a sample SyncServer application configuration file 
including the full set
of configuration options available for the v3.2 server.

**Note:** 

- The version numbers in the file names may differ but this intended. 
  After the update process there can be files remaining with the same name,
  but different version numbers, e.g.
  ```
  FloeNavi-SyncServer-2.1.0-SNAPSHOT.jar
  FloeNavi-SyncServer-2.2.0-SNAPSHOT.jar
  ```
  In this case, please remove the file from the installation directory,
  and **keep** the file added from the extracted patch archive.

## 3. Adjusting the configuration file
  
The SyncServer v3.2 provides the same set of configurable options 
to control the new features that are provided by the update as SyncServer v3.1.

If you decide to migrate to the new application.yaml provided in the patch archive, ensure that
the content is reflecting your current installation.

```
floenavi:
    adminToken: 0123456789abcdef
    app:
        # Security and admin pin of the Apps. Must adhere to pattern [0-9]{4} (4 digits)
        adminPin: "<insert admin pin here>"
        securityPin: "<insert security pin here>"

        # MMSI of the mothership. Must adhere to pattern [0-9]{9} (9 digits)
        mmsiMothership: "<insert mmsi of the mothership here>"
        maps: "<insert path to folder with maps>"
    database:
        mysql:
            host: localhost
            port: 3306
            schema: floenavi
            user: "<insert user name>"
            password: "<insert password here>"
logging:
    file:
        path: "<insert absolute path of log directory here>"
```

#### `adminToken:` Grid Update Security Token

The admin token is a secret protection key that needs to be supplied 
to the request for deleting the currently configured grid on the SyncServer.
The length should be at least 16 alphanumerical characters

#### `app:` Configuration Options to send to the App
- `adminPin` The pin that protects the admin views
- `securityPin` The pin that protects the deletion of a configured grid
- `mmsiMothership` The MMSI of the Mothership, special icon is shown on the map
- `maps` the directory on the SyncServer host which contains the map image, e.g. `"C:\\Maps"`

#### `logging:` Audit-Logfile

Starting with v3.1 the SyncServer will write a logfile containing the number
of synchronized elements (device operations, device information).

Specified here must be the directory that should contain the SyncServer logfiles.

In addition to the audit log, the SyncServer will create a second logfile with
internal technical messages, i.e. database connection details and framework startup messages.

**Note:**
- The configured directory will be created if it does not yet exist.
- Logfiles are rotated per default every 30 days

## 4. Restarting the Server

Now the server can be restarted.