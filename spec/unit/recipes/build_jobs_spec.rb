#
# Cookbook Name:: chef-server-backup
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chef_server_backup::build_jobs' do
  context 'When all attributes are default, and sparsely create populated data bag' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(:step_into => ['chef_server_backup_job']) do |_node, server|
        server.create_data_bag('chef_server_backup', {
                                 'dc01' => {
                                   'url'       => 'https://chef.example.com/',
                                   'directory' => '/foo/bar/dc01',
                                   'key'       => "-----BEGIN RSA PRIVATE KEY-----\nMIIEow..."
                                 }
                               })
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates the job' do
      expect(chef_run).to create_backup_job('dc01')
    end

    it 'creates the backup directory' do
      expect(chef_run).to create_directory('/foo/bar/dc01')
    end

    it 'creates the knife.pem' do
      expect(chef_run).to create_template('/foo/bar/dc01/knife.pem')
    end

    it 'creates the knife.rb' do
      expect(chef_run).to create_template('/foo/bar/dc01/knife.rb')
    end

    it 'creates the cron job' do
      expect(chef_run).to create_cron_d('dc01')
    end
  end

  context 'When all attributes are default, and sparsely populated delete data bag' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: ['chef_server_backup_job']) do |_node, server|
        server.create_data_bag('chef_server_backup', {
                                 'zz-del-dc01' => {
                                   'name' => 'dc01',
                                   'action' => 'delete'
                                 }
                               })
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    dest_dir = ::File.join(Chef::Config['file_backup_path'], 'dc01')

    it 'deletes the job' do
      expect(chef_run).to delete_backup_job('dc01')
    end

    it 'deletes the backup directory' do
      expect(chef_run).to delete_directory(dest_dir)
    end

    it 'deletes the knife.pem' do
      expect(chef_run).to delete_file(::File.join(dest_dir, 'knife.pem'))
    end

    it 'deletes the knife.rb' do
      expect(chef_run).to delete_file(::File.join(dest_dir, 'knife.rb'))
    end

    it 'deletes the cron job' do
      expect(chef_run).to delete_cron_d('dc01')
    end
  end
end
