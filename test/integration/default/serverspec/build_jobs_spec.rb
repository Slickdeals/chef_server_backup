require 'spec_helper'

describe 'chef_server_backup::build_jobs' do
  describe file('/var/chef/backup/dc01/knife.rb') do
    its(:content) { should contain('https://chef.example.com').after('chef_server_url') }
    its(:content) { should contain('backup').after('node_name') }
    its(:content) { should contain('/var/chef/backup/dc01/knife.pem') }
  end

  describe file('/var/chef/backup/dc01/backup.sh') do
    its(:content) { should contain('-c /var/chef/backup/dc01/knife.rb') }
    its(:content) { should contain('-D /var/chef/backup/dc01').after('knife backup export') }
    its(:content) { should contain('-C /var/chef/backup/dc01').after('tar') }
    its(:content) { should contain('cf /var/chef/backup/dc01/\$\(date "\+%F"\).tgz \$\(date "\+%F"\)') }
  end

  describe file('/var/chef/backup/dc01/knife.pem') do
    its(:content) { should contain 'BEGIN RSA' }
  end

  describe file('/etc/cron.d/dc01-backup') do
    its(:content) { should contain('/var/chef/backup/dc01/backup.sh') }
  end

  describe file('/etc/cron.d/dc01-backup-clean') do
    its(:content) { should contain('find /var/chef/backup/dc01/') }
    its(:content) { should contain('-type f -name "\*\.tgz"') }
    its(:content) { should contain('-mtime \+31') }
    its(:content) { should contain('-delete') }
  end
end
