#
# Cookbook Name:: chef_server_backup
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

chef_gem "knife-backup" do # ~FC009
  action [:install]
  compile_time false
  version node['chef_server_backup']['knife-backup']['version']
end
