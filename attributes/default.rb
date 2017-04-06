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
default['xenforo']['private_ip'] = node['network']['interfaces']['eth0']['addresses'].keys[1]
default['xenforo']['cookie_domain'] = '.bigpoint.com'
default['xenforo']['redirect_url'] = nil
default['xenforo']['use_bp_percona'] = true
default['xenforo']['repo_changed_file'] = '/tmp/repo-changed'
default['xenforo']['use_nexus_deploy'] = false
default['xenforo']['nexus']['external'] = false
default['xenforo']['nexus']['auth'] = false
default['xenforo']['ssl']['enable'] = false
default['xenforo']['ssl']['data_bag_item'] = 'xenforo'
default['xenforo']['ssl']['protocol'] = 'All -SSLv2 -SSLv3'
default['xenforo']['ssl']['ciphersuite'] = 'EDH+CAMELLIA:EDH+aRSA:EECDH+aRSA+AESGCM:EECDH+aRSA+SHA384:EECDH+aRSA+SHA256:EECDH:+CAMELLIA256:+AES256:+CAMELLIA128:+AES128:+SSLv3:!aNULL:!eNULL:!LOW:!3DES:!MD5:!EXP:!PSK:!DSS:!RC4:!SEED:!ECDSA:CAMELLIA256-SHA:AES256-SHA:CAMELLIA128-SHA:AES128-SHA'
default['xenforo']['upload_max_filesize'] = '4M'
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
default['xenforo']['cdn']['external_data_url'] = 'https://xenforo-1028-storage.bpsecure.com/' # e.g. 'https://xenforo-1028-storage.bpsecure.com'
default['xenforo']['cdn']['host'] = 'xenforo.upload.akamai.com'
default['xenforo']['cdn']['provider'] = 'akamai'
default['xenforo']['cdn']['user'] = 'sshacs'
default['xenforo']['cdn']['port'] = 22
default['xenforo']['cdn']['credentials_directory'] = '/etc/xenforo'
default['xenforo']['cdn']['public_key'] = 'akamai_id_rsa.pub'
default['xenforo']['cdn']['private_key'] = 'akamai_id_rsa'
default['xenforo']['cdn']['storagePath'] = '/562177/'
default['xenforo']['debug'] = false
default['xenforo']['social']['data_bag_item'] = nil
default['xenforo']['debug'] = false
default['xenforo']['redirector']['server_name'] = 'board.bigpoint.com'
default['xenforo']['redirector']['redirect_domain'] = 'bigpoint.com'
