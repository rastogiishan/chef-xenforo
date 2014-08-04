require 'chefspec'

describe 'xenforo::_firewall' do
  let(:chef_run) {
    chef_run = ChefSpec::ChefRunner.new
    chef_run.node.automatic_attrs['platform_family'] = 'debian'
    chef_run.node.automatic_attrs['os'] = 'linux'
    chef_run.node.automatic_attrs['lsb'] = { 'codename' => 'squeeze' }
    chef_run.node.set['xenforo'] = { 'name' => 'xentest',
                                     'instance' => '01',
                                     'enable_ssl' => false }
    chef_run.converge 'xenforo::_firewall'
    chef_run
  }
 
  it 'service script installed' do
    expect(chef_run).to create_file_with_content '/etc/init.d/firewall', '/sbin/iptables -A INPUT -p tcp --dport 80 -j ACCEPT'
  end

  it 'firewall service' do
    expect(chef_run).to start_service 'firewall'
    expect(chef_run).to set_service_to_start_on_boot 'firewall'
  end
end
