# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Bigpoint xenForo memcache
# Recipe::              memcache
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

group node['memcached']['group'] do
  action :create
end

user node['memcached']['user'] do
  comment 'memcache'
  group node['memcached']['group']
  system true
  home '/tmp'
end

include_recipe "memcached::default"
#memcached_instance node['xenforo']['name']
