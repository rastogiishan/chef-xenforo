# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Bigpoint xenForo memcache
# Recipe::              memcache
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

group node['memcached']['group'] do
  action :create
  not_if node['memcached']['group'].nil?
end

user node['memcached']['user'] do
  comment 'memcache'
  group node['memcached']['group']
  system true
  home '/tmp'
  not_if node['memcached']['user'].nil?
end

include_recipe 'memcached::default'
# memcached_instance node['xenforo']['name']
