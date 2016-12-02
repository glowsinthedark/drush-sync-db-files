<?php
// yoursite.com.local
$sites = '/local/sites/path/';
$aliases['local'] = array(
  'uri' => 'yoursite.com.local',
  'root' => $sites . 'yoursite.com/public_html',
  'path-aliases' => array(
    '%dump-dir' => $sites . 'drush.dbdumps',
    '%files' => $sites . 'yoursite.com/public_html/sites/yoursite.com/files'
  )
);

// yoursite.com
$remote_site_root = '/path/to/public_html/';
$aliases['prod'] = array(
  'uri' => 'yoursite.com',
  'remote-host' => 'yoursite.com',
  'remote-user' => 'yoursite',
  'root' => $remote_site_root,
  'path-aliases' => array(
    '%dump-dir' => '/home/yoursite/drush.dbdumps',
    '%files' => $remote_site_root . 'sites/yoursite.com/files'
  ),
  'command-specific' => array(
   'sql-dump' => array(
      'structure-tables-list' => 'cache*,ctools_css_cache,ctools_object_cache,history,sessions,search*,watchdog'
    ),
  ),
);