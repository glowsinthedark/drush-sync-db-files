## Drush MySQL and File Sync Shell Script

* This utilizes `drush sql-sync` and `drush rsync` to pull down a production server's file system and database to your local version by executing the shell script.
* You must have a drush aliases file set up with local and prod aliases for this to work. Sample included at the end of the shell script.
* Fill out the top variables of the shell script and then run it. It assumes your local environment can log in to the remote environment via SSH already.