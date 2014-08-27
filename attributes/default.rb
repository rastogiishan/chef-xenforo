# Encoding: UTF-8
default['xenforo']['domainname'] = 'bigpoint.com'
default['xenforo']['names'] = []
node['tags'].each do |t|
  default['xenforo']['names'] << t[t.index('-') + 1, t.size - 1] if t.start_with?('id-')
end
fail 'No node name fount' if node['xenforo']['names'].empty?
default['xenforo']['db']['data_bag_item'] = node['xenforo']['names'].length == 1 ? node['xenforo']['names'][0] : "xenforo"
default['xenforo']['server_name'] = 'localhost' # should be set in the node
default['xenforo']['htdocs_xenforo'] = "#{node['apache']['docroot_dir']}/#{node['xenforo']['names'][0]}"
default['xenforo']['htdocs_maintenance'] =  "#{node['apache']['docroot_dir']}/maintenance"
# Local logging: "\"#{node['apache']['log_dir']}/#{node['xenforo']['name'][0]}-access.log\"" common"
# Disable with: common env=!dontlog
default['xenforo']['customlog'] = "\"|/usr/bin/logger -t #{node['apache']['package']} -p local6.info\" combined"
# "\"#{node['apache']['log_dir']}/#{node['xenforo']['name'][0]}-error.log\""
default['xenforo']['errorlog'] = "syslog:local7"
# space seperated list - should be set in node
default['xenforo']['server_aliases'] = "xenforo-vagrant.#{node['xenforo']['domainname']}"
default['xenforo']['redirect_url'] = nil
default['xenforo']['use_bp_percona'] = true
default['xenforo']['ssl']['enable'] = false
default['xenforo']['ssl']['data_bag_item'] = 'xenforo'
default['xenforo']['ssl']['protocol'] = '-ALL +SSLv3 +TLSv1 +TLSv1.1 +TLSv1.2'
default['xenforo']['ssl']['ciphersuite'] = 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:!RC4:HIGH:!MD5:!aNULL:!EDH'
default['xenforo']['enable_htpasswd'] = false
default['xenforo']['htpasswd_file'] = "#{node['apache']['dir']}/htpasswd-#{node['xenforo']['names'][0]}"
default['xenforo']['htdocs_group'] = 'xenforo'
default['xenforo']['repository'] = 'ssh://git@gitlab.bigpoint.net/xenforo/board.git'
default['xenforo']['repository_revision'] = 'staging'
default['xenforo']['repository_destination'] = '/var/workspace/board'
default['xenforo']['repository_addons'] = 'ssh://git@gitlab.bigpoint.net/xenforo/addons.git'
default['xenforo']['repository_addons_revision'] = 'staging'
default['xenforo']['repository_addons_destination'] = '/var/workspace/addons'
default['xenforo']['install_allow_from'] = '10.188.0.0/16'
default['xenforo']['enable_mail'] = false
default['xenforo']['super_admins'] = '1'
default['xenforo']['external_data_path'] = nil
default['xenforo']['java_script_url'] = nil
default['xenforo']['cdn']['external_data_url'] = nil # f.ex. 'http://xenforo-1028.level3.bpcdn.net/'
default['xenforo']['cdn']['host'] = 'xenforo-1028-storage.ingest.cdn.level3.net'
default['xenforo']['cdn']['provider'] = 'level3'
default['xenforo']['cdn']['user'] = 'xenforo'
default['xenforo']['cdn']['port'] = 22
default['xenforo']['debug'] = false
