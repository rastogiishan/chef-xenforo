# Encoding: UTF-8
actions :update
attribute :name, :kind_of => String
attribute :extension, :kind_of => String
attribute :groupid, :kind_of => String
attribute :nexus_server, :kind_of => String
attribute :nexus_username, :kind_of => String
attribute :nexus_password, :kind_of => String
attribute :repository, :kind_of => String, :default => 'release'
attribute :version, :kind_of => String, :default => 'LATEST'
attribute :classifier, :kind_of => String, :default => ''
attribute :destination, :kind_of => String
attribute :owner, :kind_of => String, :default => 'root'
attribute :group, :kind_of => String, :default => 'root'
attribute :mode, :kind_of => String, :default => '0700'

def initialize(*args)
  super
  @action = :create
end
