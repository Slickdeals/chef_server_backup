#
# Cookbook Name:: chef_server_backup
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

chef_server_backup_job "sdhq" do
  url "https://chef.sdhq.local"
  directory "/var/chef/backup/meow"
  key "dsa BAAAAA"
end

