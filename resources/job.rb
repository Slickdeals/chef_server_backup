actions :create, :delete
default_action :create

attribute :name,        :kind_of => String, :name_attribute => true, :required => true
attribute :url,         :kind_of => String, :required => true
attribute :key,         :kind_of => String, :required => true
attribute :directory,   :kind_of => String, :required => true
attribute :backup_user, :kind_of => String, :default => "root"
attribute :chef_user,   :kind_of => String, :default => "backup"
attribute :minute,      :kind_of => [Integer, String], :default => "0"
attribute :hour,        :kind_of => [Integer, String], :default => "0"
attribute :day,         :kind_of => [Integer, String], :default => "*"
attribute :month,       :kind_of => [Integer, String], :default => "*"
attribute :weekday,     :kind_of => [Integer, String], :default => "*"

attr_accessor :exists
