# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Simple iptables with syn flood prevention
# Recipe::              firewall.rb
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

if !node['xenforo']['ssl']['enable']
  ports = [80]
else
  ports = [80, 443]
end

template '/etc/init.d/firewall' do
  source 'firewall.erb'
  user 'root'
  variables('ports' => ports)
  mode 0755
end

service 'firewall' do
  action [:enable, :start]
  supports :status => false, :start => true, :stop => true, :restart => true
end
