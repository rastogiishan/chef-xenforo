# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         A micro webserver for redirecting old addresses to new xenForo instances
# Recipe::              redirector
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

node.set['nginx']['default_site_enabled'] = false
include_recipe 'nginx::default'

template "#{node['nginx']['dir']}/sites-available/redirector" do
  source 'site_redirector.erb'
  notifies :reload, 'service[nginx]', :delayed
end

nginx_site 'redirector'
