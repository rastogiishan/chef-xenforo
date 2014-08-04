# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Simple iptables with syn flood prevention
# Recipe::              firewall.rb
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

if !node['xenforo']['enable_ssl']
  port = 80
else
  port = 443
end

template '/etc/init.d/firewall' do
  source 'firewall.erb'
  user 'root'
  variables('port' => port)
  mode 0755
end

service 'firewall' do
  action    [:enable, :start]
  supports :status => false, :start => true, :stop => true, :restart => true
end
