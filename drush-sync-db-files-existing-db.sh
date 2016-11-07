#############################################################################################
# MySQL Drush Alias Database Loader Scripts
#
# By David Lohmeyer
# vilepickle@gmail.com
# 11/7/2016 Version 1.1
#
# THIS SCRIPT ASSUMES ~/.drush/aliases.drushrc.php IS FILLED OUT PROPERLY! SEE DEMO AT END
# OF FILE.
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

# SAMPLE ~/.drush/site.aliases.drushrc.php
#
# <?php
# // yoursite.com.local
# $sites = '/home/david/gfs/';
# $aliases['local'] = array(
#   'uri' => 'yoursite.com.local',
#   'root' => $gfs_sites . 'yoursite.com/public_html',
#   'path-aliases' => array(
#     '%dump-dir' => $sites . 'drush.dbdumps',
#     '%files' => $sites . 'yoursite.com/public_html/sites/yoursite.com/files'
#   )
# );
# 
# // yoursite.com
# $remote_site_root = '/home/leadmgmt/app/leadmanagement/public_html/';
# $aliases['prod'] = array(
#   'uri' => 'yoursite.com',
#   'remote-host' => 'yoursite.com',
#   'remote-user' => 'yoursite',
#   'root' => $remote_site_root,
#   'path-aliases' => array(
#     '%dump-dir' => '/home/yoursite/drush.dbdumps',
#     '%files' => $remote_site_root . 'sites/yoursite.com/files'
#   ),
# );
