# FloeNavi

## FloeNavi SyncServer

### Installation
You can install the FloeNavi SyncServer on Linux, macOS, or Windows.

#### Prerequisites

##### Java Runtime Environment
The FlowNavi Sync Server runs on all major operating systems and requires only a Java Development Kit version 11 to run.
To check if a Java Development Kit has already been installed on your system and if the environment variable `JAVA_HOME` is set, run the following command in your console and check its output.

###### Windows
```bash
%JAVA_HOME%/bin/java.exe -version
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)
```

###### Mac
```bash
$JAVA_HOME/bin/java -version
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)
```

###### Linux
```bash
$JAVA_HOME/bin/java -version
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)
```

If Java has not been installed on your system or if the installed version is not 11.0.2 then download one of these

- Windows: https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_windows-x64_bin.zip ([sha256](https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_windows-x64_bin.zip.sha256))
- Mac: https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_osx-x64_bin.tar.gz ([sha256](https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_osx-x64_bin.tar.gz.sha256))
- Linux: https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz ([sha256](https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz.sha256))

Java Development Kits or take a look into your delivery package. You will find a file `openjdk-11.0.2_windows-x64_bin.zip`.

Extract the downloaded archive into a folder, e.g.
- Window: `C:\Program Files\Java`
- Mac: `/Library/Java/JavaVirtualMachines`
- Linux: `/opt/java/`

and set your `JAVA_HOME` environment variable to the installed Java version as follows
###### Windows
```bash
setx JAVA_HOME "C:\Program Files\Java\jdk-11.0.2"
```
Note: Close and reopen your console afterwards, so that the setting becomes active.

###### Mac
```bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home
```

###### Linux 
```bash
export JAVA_HOME=/opt/java/jdk-11.0.2/
```

Now repeat the first step to check if Java has already been installed in order to check if java has been installed sucessfully. Run the following command in your console and check the output.

###### Windows
```bash
%JAVA_HOME%/bin/java.exe -version
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)
```

###### Mac
```bash
$JAVA_HOME/bin/java -version
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)
```

###### Linux
```bash
$JAVA_HOME/bin/java -version
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)
```

##### MySQL Server
The FloeNavi Sync Server also requires a MySQL Server. If MySQL is not installed, please follow the instructions in section 2.3.4 
of the MySQL Manual. You can find the manual online or take a look into your delivery package and look for a file `mysql-manual-8.0-en.pdf`.
If you cannot download the MySQL server you'll find a MySQL Server in your delivery package. Look for a file `mysql-8.0.20-winx64.zip`.

#### Get FloeNavi SyncServer
If you have a delivery package then look for a file named `FloeNavi-SyncServer-Full-x.x.x.zip`, otherwise you can download 
the FloeNavi SyncServer from GitHub. Take a look at the releases.    

#### Extract the zip or tar file
Extract the file `FloeNavi-SyncServer-Full-x.x.x.zip` into a directory of your choice, e.g.
- Window: `C:\Program Files\FloeNavi`
- Mac: `/opt/FloeNavi`
- Linux: `/opt/FloeNavi`

#### Configure Database (MySQL)
The FloeNavi SyncServer requires a MySQL Server. Before you can start the FloeNavi SyncServer you have to configure the connection to you MySQL server. Therefore open the file `\Program Files\FloeNavi\FloeNavi-SyncServer\etc\application.yaml` and adjust the properties `floenavi.database.mysql.user` and `floenavi.database.mysql.password`. Replace the user with a valid MySQL user and password with its password. If MySQL is not running on the same machine or uses a different port then adjust the properties `floenavi.database.mysql.host` and `floenavi.database.mysql.port`, too. `floenavi.database.mysql.schema` is database that the FloeNavi SyncServer will use. You do not have to create the database, if the user has the permission to create databases and you do not have to create any tables. This will be done by the FloeNavi SyncServer when it is started the first time.

### Usage
The Sync server can be started via a start script as follows

###### Windows
```bash
cd "C:\Program Files\FloeNavi\FloeNavi-SyncServer"
bin/FloeNavi-SyncServer.bat
```

###### Mac
```bash
cd /opt/FloeNavi/FloeNavi-SyncServer/
bin/FloeNavi-SyncServer
```

###### Linux 
```bash
cd /opt/FloeNavi/FloeNavi-SyncServer/
bin/FloeNavi-SyncServer
```

After you executed the script you should see a similar output like this
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.2.6.RELEASE)

2020-05-06 12:18:48.534  INFO 55041 --- [           main] de.awi.floenavi.syncserver.Application   : Starting Application on Sebastians-MacBook-Pro-2.local with PID 55041 (/Users/stse/Projects/C25118-AWI-Polarstern/workspaces/FloeNavi-SyncServer/build/classes/java/main started by stse in /Users/stse/Projects/C25118-AWI-Polarstern/workspaces/FloeNavi-SyncServer)
2020-05-06 12:18:48.542  INFO 55041 --- [           main] de.awi.floenavi.syncserver.Application   : No active profile set, falling back to default profiles: default
2020-05-06 12:18:49.035  INFO 55041 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2020-05-06 12:18:49.041  INFO 55041 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2020-05-06 12:18:49.041  INFO 55041 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.33]
2020-05-06 12:18:49.087  INFO 55041 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2020-05-06 12:18:49.087  INFO 55041 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 519 ms
2020-05-06 12:18:49.193  INFO 55041 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2020-05-06 12:18:49.309  INFO 55041 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2020-05-06 12:18:49.313  INFO 55041 --- [           main] de.awi.floenavi.syncserver.Application   : Started Application in 0.967 seconds (JVM running for 1.393)
```

To check if the FloeNavi SyncServer is running open the url `http://localhost:8080/` in your browser. You should see a description of the FloeNavi API.

## Patch
If you have downloaded a patch for the FloeNavi SyncServer and would like to patch your installation of the SyncServer then
you have to follow these steps.

1. **Stop the FloeNavi SyncServer**

   Press `Ctrl+C` in the console where the SyncServer is running. The SyncServer will shut down, and you'll get your 
   prompt back.
   
2. **Backup your database (optional but recommended)**
   Use the MySQL tools to create a backup of your database.
   
3. **Extract the patch archive**
   
   Extract the patch archive in a directory of your choice.
   
4. **Patch your FloeNavi SyncServer installation**
   
   Open the directory where the FloeNavi SyncServer has been installed into. You should see among others a folder named 
   `lib`. Replace all files in this folder with files from the `lib` folder in the extracted patch archive. 
   
   **Note:** The version numbers in the file names may differ but this intended. So please replace, e.g. file xyz-1.0.0.jar in
   your instalation with file xyz-2.0.0.jar form the patch.
   
   Afterwards you can restart the FloeNavi SyncServer as described above again.

## Usage

### Import devices

A device can be imported using the following curl command.

```bash
curl --request POST --url http://localhost:8080/devices \
--header 'content-type: application/x-www-form-urlencoded' \
--data DEVICE_ID=6180 \
--data 'DEVICE_NAME=seawater tap' \
--data DEVICE_SHORT_NAME=seawatertap_ps \
--data 'DEVICE_TYPE=Water Sampler' --data 'ACTIONS=hoisting,in the water,information,lowering,on deck' 
```

If the FloeNavi SyncServer is running then you should get Http status code 200. You can check if the device is actually imported by synchronizing a tablet with the FloeNavi App or running the following curl command.

```bash
curl --request GET --url http://localhost:8080/devices \
--header 'Accept: application/json'
```

You should get the following output or something similar.

```bash
curl --request GET --url http://localhost:8080/devices \
--header 'Accept: application/json'

[ {
  "id" : 6180,
  "name" : "seawater tap",
  "shortName" : "seawatertap_ps",
  "type" : "Water Sampler",
  "actions" : [ "information", "lowering", "on deck", "in the water", "hoisting" ]
} ]
```

### Export device operations

Before you can export some device operation you have to capture them. First we have to capture some device operations in the FloeNavi App and second the the tablet with the FloeNavi has to be synchronized with the FloeNavi SyncServer.

After some device information have been created you can export these device information as CSV using this curl command

```bash
curl --request GET --url http://localhost:8080/operations
```

You should get an output similar to this one

```bash
curl --request GET --url http://localhost:8080/operations  
2020-05-11T14:56:47.016Z;87.823389;90.027728;40023.384966016325;6649.390883474067;ds lead;refrozen lead. 0cm snow. old frost flowers;6180;1;lowering
2020-05-11T14:57:20.885Z;87.823389;90.027728;40023.384966016325;6649.390883474067;ds lead;refrozen lead. 0cm snow. old frost flowers;6180;2;hoisting
```
