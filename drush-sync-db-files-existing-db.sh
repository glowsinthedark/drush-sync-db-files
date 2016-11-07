#############################################################################################
# MySQL Drush Alias Database Loader Scripts
#
# By David Lohmeyer
# vilepickle@gmail.com
# 11/7/2016 Version 1.1
#
# THIS SCRIPT ASSUMES ~/.drush/site.aliases.drushrc.php IS FILLED OUT PROPERLY! See demo in
# Git repository.
#
# THIS SCRIPT ASSUMES A DATABASE ALREADY EXISTS.
#
#############################################################################################

DO_FILES=1
DO_DATABASE=1
DRUSHSRC="@site.prod"
DRUSHDEST="@site.local"

#############################################################################################


#Also sync files?

#############################################################################################
# No need to edit below this line.

if [ $DO_DATABASE = 1 ]
  then
    # Sync the DB
    echo "Syncing '$DATABASE' with defined drush aliases..."
    drush $DRUSHDEST sql-drop -y
    drush sql-sync $DRUSHSRC $DRUSHDEST -y
  else
    echo 'Database not synced...'
fi


if [ $DO_FILES = 1 ]
  then
    echo 'Syncing files from source with drush rsync...'
    drush -y rsync $DRUSHSRC:%files/ $DRUSHDEST:%files
  else
    echo 'Files not synced...'
fi
