name             'chef_server_backup'
maintainer       'D3'
maintainer_email 'hipster@slickdeals.net'
license          'BSD 3-Clause'
description      'Sets up automated chef-server backups using knife-backup'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'

depends 'cron'
