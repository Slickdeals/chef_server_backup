# chef_server_backup

This sets up remote backups (dumps) of chef servers using [knife-backup](https://github.com/mdxp/knife-backup)

## Requirements
Tested on CentOS 6 and Ubuntu 14.04

## Attributes
* `node['chef_server_backup']['knife-backup']['version']` *(String) default "0.0.10"*
* `node['chef_server_backup']['data_bag_name']` *(String) default "chef_server_backup"*

## Recipes
### Default
Installs the knife-block gem into the chef instance of ruby

### build_jobs
Set up backup directories and cron jobs for backing up chef servers from the chef_server_backup data bag

## Resources/Providers
### job
Set up or delete a chef_server_backup directory and cron job

#### Parameters
##### Required:
* `name` - Short name of the job, must match `[\w\d_-]+`
* `url` - full url to your chef instance (including orginization if needed)
* `key` - the private key of the backup user on the chef server (this user should have full read permissions to all objects)

##### Optional:
- `directory` - directory to back up the chef dump to (Default: File.join(Chef::Config['file_backup_path'], name))
- `backup_user` - System user to back up as (Default: root)
- `backup_group` - System group to add to backup directory and files (Default: root)
- `chef_user` - Chef user to set as node_name (Default: backup)
- `minute` - Minute column of cron entry (Default: 0)
- `hour` - Hour column of cron entry (Default: 0)
- `day` - Day column of cron entry (Default: *)
- `month` - Month column of cron entry (Default: *)
- `weekday` - Weekday column of cron entry (Default: *)

## Usage
To use the `recipe[chef_server_backup::build_jobs]` include it in your run list and have a daga bag called `chef_server_backup` with an item like the following recipe;

```
### you can leave out the name and the name of the data bag item will be used
{
  "url"       : "https://chef.example.com/",
  "directory" : "/var/chef/backup/dc01",
  "key"       : "-----BEGIN RSA PRIVATE KEY-----\nMIIEow..."
}
```

or a backup job to be removed:

```
{
  "name"   : "dc03",
  "action" : "remove"
}
```

If you would rather use a wrapper cookbook instead of data bags include `chef_server_backup::default` to install knife backup and make the LWRP availible to your cookbook

## Development
Rake is set up to run all the tests! Make sure to add chefspec as needed.

## Licence & Authors
- Authors:
 - David Aronsohn <hipster@slickdeals.net>

```text
Copyright (c) 2015 Slickdeals, LLC
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
