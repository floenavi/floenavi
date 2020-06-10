# Upgrade from v1 to v3

This document describes the upgrade process to install
the incremental update from v1 to v3.

**Note:**

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
   
   Afterwards you can restart the FloeNavi SyncServe