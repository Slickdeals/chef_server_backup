#
# Cookbook Name:: chef_server_backup
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

chef_gem 'knife-backup' do # ~FC009
  action [:install]
  compile_time false if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time) # For Chef 11
  version node['chef_server_backup']['knife-backup']['version']
end
