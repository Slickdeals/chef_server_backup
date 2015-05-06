def whyrun_supported?
  true
end

use_inline_resources

action :create do
  directory backup_dir do
    action :create
    mode   0750
    user   new_resource.backup_user
    group  new_resource.backup_group
    recursive true
  end

  template knife_pem do
    source "pem.erb"
    owner  new_resource.backup_user
    group  new_resource.backup_group
    mode 0640
    variables({
      :key => new_resource.key
    })
  end

  template knife_rb do
    source "knife.erb"
    owner  new_resource.backup_user
    group  new_resource.backup_group
    mode   0640
    variables({
      :chef_user => new_resource.chef_user,
      :key       => knife_pem,
      :server    => new_resource.url
    })
  end

  cron_d new_resource.name do
    command "knife backup export -D #{ backup_dir } --latest -c #{ knife_rb }"
    path    "/opt/chef/bin/:$PATH"
    user    new_resource.backup_user
    minute  new_resource.minute
    hour    new_resource.hour
    day     new_resource.day
    month   new_resource.month
    weekday new_resource.weekday
  end
end

action :delete do
  cron_d new_resource.name do
    action :delete
  end
  file knife_rb do
    action :delete
  end
  file knife_pem do
    action :delete
  end
  directory backup_dir do
    action :delete
  end
end


def backup_dir
  new_resource.send('directory') || ::File.join(Chef::Config['file_backup_path'], new_resource.name)
end

def knife_rb
  ::File.join(backup_dir, "/#{ new_resource.name }-knife.rb")
end

def knife_pem
  ::File.join(backup_dir, "/#{ new_resource.name }-knife.pem")
end
