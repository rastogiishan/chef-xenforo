# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Bigpoint xenForo forum
# Recipe::              _deploy_nexus.rb
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

fail 'Only one name allowed' unless node['xenforo']['names'].length == 1
xenforo_package = data_bag_item('xenforo', "deployment-#{node['xenforo']['names'][0]}")['xenforo']

NEXT_DIR = "#{node['xenforo']['htdocs_xenforo']}-next"

directory NEXT_DIR do
  recursive true
  only_if { File.exist? NEXT_DIR }
  action :delete
end

if node['xenforo']['nexus']['auth']
  nexus_auth = Chef::EncryptedDataBagItem.load('xenforo', 'nexusauth')[node['xenforo']['names'][0]]
else
  nexus_auth = nil
end

xenforo_nexuspackage xenforo_package['artifact'] do
  repository xenforo_package['repository']
  groupid xenforo_package['groupid']
  nexus_server node['xenforo']['nexus']['external'] ? xenforo_package['host_external'] : xenforo_package['host']
  nexus_username nexus_auth['username'] if node['xenforo']['nexus']['auth']
  nexus_password nexus_auth['password'] if node['xenforo']['nexus']['auth']
  extension xenforo_package['extension']
  version xenforo_package['version']
  classifier xenforo_package['classifier']
  destination NEXT_DIR
  owner 'root'
  mode '0755'
  action :update
end

bash 'nexus_file_deploy' do
  user 'root'
  environment 'BOARD' => node['xenforo']['repository_destination'],
              'ADDONS' => node['xenforo']['repository_addons_destination'],
              'HT' => node['xenforo']['htdocs_xenforo'],
              'HTOLD' => "#{node['xenforo']['htdocs_xenforo']}-old",
              'HTNEW' => NEXT_DIR
  code <<-EOH
    (cp -R $HT/data/. $HTNEW/data/; cp -R $HT/internal_data/. $HTNEW/internal_data/; true) && \
    rm -rf $HTNEW/.git $HTNEW/.project $HTNEW/.buildpath $HTNEW/.settings && \
    chgrp -R #{node['xenforo']['htdocs_group']} $HTNEW && \
    chmod -R g+rw $HTNEW && \
    chown -R #{node['apache']['user']} $HTNEW/data $HTNEW/internal_data && \
    mv $HT $HTOLD && \
    mv $HTNEW $HT && \
    rm -rf $HTOLD && \
    killall -HUP apache2
  EOH
  only_if { File.exist? NEXT_DIR }
  #  notifies :run, 'execute[generate_status_script]', :delayed
  # notifies config.php should not be needed. Changed and should be restored therefor below
end
