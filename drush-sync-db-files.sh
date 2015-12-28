#############################################################################################
# MySQL and File Sync Drush Sync Script
#
# By David Lohmeyer
# vilepickle@gmail.com
# 12/24/15 Version 1.0
#
# THIS SCRIPT ASSUMES ~/.drush/site.aliases.drushrc.php IS FILLED OUT PROPERLY! SEE DEMO AT END
# OF FILE.
#
#############################################################################################

DO_FILES=1
DO_DATABASE=1
DRUSHSRC="@site.prod"
DRUSHDEST="@site.local"

# DATABASE CREDS
SERVER="127.0.0.1"
PORT="3306"
USER="root"
PW="overworked"
DATABASE="your_db_name"

#############################################################################################


#Also sync files?

#############################################################################################
# No need to edit below this line.

if [ $DO_DATABASE = 1 ]
	then
		# Check to see if database exists
		DBS=`mysql -u$USER -p$PW -h $SERVER -Bse 'show databases'| egrep -v 'information_schema|mysql'`
		FOUNDDB=0
		for db in $DBS; do
			if [ $db = $DATABASE ]
				then
					FOUNDDB=1
			fi
		done
		if [ $FOUNDDB = 0 ]
			then
				# Create a new database
				echo "Didn't find the database, creating '$DATABASE'..."
				mysqladmin -u$USER -p$PW -h $SERVER --port $PORT create $DATABASE
		fi
		# Sync the DB
		echo "Syncing '$DATABASE' with defined drush aliases..."
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

