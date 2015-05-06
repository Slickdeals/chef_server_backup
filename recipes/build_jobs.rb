#
# Cookbook Name:: chef_server_backup
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#

include_recipe "chef_server_backup::default"

bag = node['chef_server_backup']['data_bag_name']

servers = data_bag(bag)
servers.each do |server|
  job = data_bag_item(bag, server)
  job_name = job['name'] || server.to_s

  chef_server_backup_job job_name do
    %w(url key directory backup_user backup_group
       chef_user minute hour day month weekday).each do |attr|
      send(attr, job[attr]) if job[attr]
    end
    action Array(job['action']).map(&:to_sym) if job['action']
  end
end
