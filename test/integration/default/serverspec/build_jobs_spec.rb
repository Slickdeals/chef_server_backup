require 'spec_helper'

describe 'chef_server_backup::build_jobs' do

  describe file('/var/chef/backup/dc01/knife.rb') do
    its(:content) { should contain('https://chef.example.com').after('chef_server_url') }
    its(:content) { should contain('backup').after('node_name') }
    its(:content) { should contain('/var/chef/backup/dc01/knife.pem') }
  end

  describe file('/var/chef/backup/dc01/knife.pem') do
    its(:content) { should contain 'BEGIN RSA' }
  end

  describe file('/etc/cron.d/dc01-backup') do
    its(:content) { should contain('-c /var/chef/backup/dc01/knife.rb') }
    its(:content) { should contain('-D /var/chef/backup/dc01').after('knife backup export') }
  end

end
