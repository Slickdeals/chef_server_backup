if defined?(ChefSpec)
  def create_backup_job(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_server_backup_job, :create, name)
  end
  def delete_backup_job(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_server_backup_job, :delete, name)
  end
end
