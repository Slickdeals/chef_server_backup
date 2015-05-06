require 'spec_helper'

describe 'chef-server-backup::default' do

  describe command('knife backup') do
    its(:stdout) { should contain 'BACKUP COMMANDS' }
  end

end
