chef_server_backup Cookbook CHANGELOG
=====================================
This file is used to list changes made in each version of the chef_server_backup cookbook.

v2.0.1 ( 2015-11-19 )
---------------------
- Fix expected file name of chef server SSL certificates

v2.0.0 ( 2015-11-19 )
---------------------
- Added a changelog
- Rename cron.d names to be `chef-#{site]-...}` instead of just `#{site}-...`
- Delete the old cron.d files
- Now will automatically run `knife ssl fetch` for the config if the file does not exist. (this is a minor security concern! You should verify this after the chef run for correctness.)

v1.2.0 (2015-06-01)
-------------------
First production release
