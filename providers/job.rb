def whyrun_supported?
  true
end

use_inline_resources

action :create do
  if false ## for the love of fuck change this
    Chef::Log.debug "#{ new_resource  } already exists - nothing to do."
  else

    directory new_resource.directory do
      action :create
      user new_resource.backup_user
      recursive true
    end

    knife_rb = ::File.join(new_resource.directory, "/#{ new_resource.name }-knife.rb")

    template knife_rb do
      source "knife.erb"
      owner  new_resource.backup_user
      mode   "0644"
      variables({
        :chef_user => new_resource.chef_user,
        :key       => new_resource.key, ## THIS IS WRONG THIS SHOULD BEW THE KEYPATH
        :server    => new_resource.url
      })
    end

    cron_d new_resource.name do
      command "knife backup export -D #{ new_resource.directory } --latest -c #{ knife_rb }"
      path    "/opt/chef/bin/:$PATH"
      minute  new_resource.minute
      hour    new_resource.hour
      day     new_resource.day
      month   new_resource.month
      weekday new_resource.weekday
    end

  end
end

action :delete do

end
