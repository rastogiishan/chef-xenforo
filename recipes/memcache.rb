# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Bigpoint xenForo memcache
# Recipe::              memcache
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

unless node['memcached']['group'].nil?
  group node['memcached']['group'] do
    action :create
  end
end

unless node['memcached']['user'].nil?
  user node['memcached']['user'] do
    comment 'memcache'
    group node['memcached']['group']
    system true
    home '/tmp'
  end
end

include_recipe 'memcached::default'
# memcached_instance node['xenforo']['name']
