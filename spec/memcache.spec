require 'chefspec'

describe 'xenforo::memcache' do
  let (:chef_run) {
    chef_run = ChefSpec::ChefRunner.new
    chef_run.node.automatic_attrs['platform_family'] = 'debian'
    chef_run.node.automatic_attrs['os'] = 'linux'
    chef_run.node.automatic_attrs['lsb'] = { 'codename' => 'squeeze' }
    chef_run.converge 'xenforo::memcache'
    chef_run
  }

  it "add group" do
    expect(chef_run).to create_group chef_run.node['memcached']['group']
    expect(chef_run).to create_user chef_run.node['memcached']['user']
  end
  
end
