# FloeNavi

## v3.1

### [Release Notes v3.1](https://github.com/floenavi/floenavi/blob/v3_1/RELEASE-NOTES.md)
### [Upgrade Instructions v1 to v3.1](https://github.com/floenavi/floenavi/blob/v3_1/UPGRADE.md)

## v3

### [Release Notes v3](https://github.com/floenavi/floenavi/blob/v3_0/RELEASE-NOTES.md)
### [Upgrade Instructions v1 to v3](https://github.com/floenavi/floenavi/blob/v3_0/UPGRADE.md)

# FlowNavi Android App

## Prerequisites
Open the Android settings and search for the "Security" settings menu. You need to allow the installation from "Unknown sources" via enabling the according checkbox.

## Requirements

- Android 6.0.1 Marshmallow
- Memory: 4GB RAM
- Display: 10.1" WXGA 1366x768

The Android App was designed for the XSLATE(tm) D10 from XPLORE Technologies

# FloeNavi SyncServer

## Prerequisites

Teh SyncServer is a native Java 11 application, and can be run on Windows, MacOS and Linux.
The installation instructions are focussed on Windows.
 
### Java Runtime Environment
The FlowNavi Sync Server runs on all major operating systems and requires only a Java Development Kit version 11 to run.
To check if a Java Development Kit has already been installed on your system and if the environment variable `JAVA_HOME` 
is set, run the following command in your console and check its output.

```bash
"%JAVA_HOME%"\bin\java.exe -version
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)
```

If Java has not been installed on your system or if the installed version is not 11.0.2 then download one of these

https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_windows-x64_bin.zip

Java Development Kits.

Extract the downloaded archive into a folder, e.g.

`C:\Program Files\Java`

and set your `JAVA_HOME` environment variable to the installed Java version as follows

```bash
setx JAVA_HOME "C:\Program Files\Java\jdk-11.0.2"
```
Note: Close and reopen your console afterwards, so that the setting becomes active.

Now repeat the first step to check if Java has already been installed in order to check if java has been installed 
sucessfully. Run the following command in your console and check its output.

```bash
"%JAVA_HOME%"\bin\java.exe -version
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)
```


##### MySQL Server
The FloeNavi Sync Server also requires a MySQL Server. If a MySQL Server is not installed, please follow the
instructions in section 2.3.4 of the MySQL Server Manual. You can find the MySQL Server Manual online at 
https://dev.mysql.com/doc/. The MySQl Server itself can be downloaded from https://dev.mysql.com/downloads/mysql/.

#### Get FloeNavi SyncServer
If you have a delivery package then look for a file named `FloeNavi-SyncServer-Full-x.x.x.zip`, otherwise you can download 
the FloeNavi SyncServer from GitHub (https://github.com/floenavi/floenavi). Take a look at the releases.    

#### Extract the zip or tar file
Extract the file `FloeNavi-SyncServer-Full-x.x.x.zip` into a directory of your choice, e.g.

`C:\Program Files\FloeNavi`

#### Configure Database (MySQL)
The FloeNavi SyncServer requires a MySQL Server. Before you can start the FloeNavi SyncServer you have to configure the 
connection to you MySQL server. 

1. Open the file `\Program Files\FloeNavi\FloeNavi-SyncServer\etc\application.yaml` 
2. Set your user name via the property `floenavi.database.mysql.user` 
3. Set your password via the property `floenavi.database.mysql.password`.

The selected user must be a valid MySQL user and must have permissions to create and alter databases and tables. 

If MySQL is not running on the same machine or does not use the default port 3306 then you have to set the following
properties, too.

- `floenavi.database.mysql.host`: Insert the IP or hostname of the machine which runs the MySQL server.
- `floenavi.database.mysql.port`: Insert the port where the MySQL Server has been bound to.
- `floenavi.database.mysql.schema`: This is the name of the database that will be created by the FloeNavi SyncServer. If a database with the name `floenavi` already exists on the MySQL server, you can choose a custom name by overwriting this property. 

You do not have to create the database, if the user has the permission to create databases, and you do not have to 
create any tables. This will be done by the FloeNavi SyncServer when it is started the first time.
