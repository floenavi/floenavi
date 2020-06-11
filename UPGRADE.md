# Upgrade from v1 to v3

This document describes the upgrade process to install
the incremental update from v1 to v3.

**Note:**

- SyncServer v1 must be installed on the SyncServer host

## 1. Preparing the Environment

1.1 **Stop the FloeNavi SyncServer**

   Press `Ctrl+C` in the console where the SyncServer is running. The SyncServer will shut down, and you'll get your 
   prompt back.
   
1.2 **Backup your database (optional but recommended)**
   Use the MySQL tools to create a backup of your database.
   

## 2. Patching the SyncServer directory

3. **Extract the patch archive**
   
Extract the patch archive `FloeNavi-SyncServer-Patch-2.0.0.zip` 
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

**Note:** 

- The version numbers in the file names may differ but this intended. 
  After the update process there can be files remaining with the same name,
  but different version numbers, e.g.
  ```
  FloeNavi-SyncServer-1.0.0-SNAPSHOT.jar
  FloeNavi-SyncServer-2.0.0-SNAPSHOT.jar
  ```
  In this case, please remove the file from the installation directory,
  and **keep** the file added from the extracted patch archive.

## 3. Adjusting the configuration file
  
The SyncServer v3 provides a set of new configurable options
to control the new features that are provided by the update.

The `application.yaml` file in the installation's folder needs to be updated to contain the following content.
Existing elements from the old file must be copied, i.e. the database settings.
The new configuration options are described below the example file content.

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
```

#### `adminToken` Grid Update Security Token

The admin token is a secret protection key that needs to be supplied 
to the request for deleting the currently configured grid on the SyncServer.
The length should be at least 20 alphanumerical characters

#### `app:` Configuration Options to send to the App
- `adminPin` The pin that protects the admin views
- `securityPin` The pin that protects the deletion of a configured grid
- `mmsiMothership` The MMSI of the Mothership, special icon is shown on the map
- `maps` the directory on the SyncServer host which contains the map image, e.g. `"C:\\Maps"`

## 4. Restarting the Server

Now the server can be restarted.