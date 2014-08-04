require 'chefspec'

describe 'xenforo::default' do
  let (:chef_run) {
    chef_run = ChefSpec::ChefRunner.new
    chef_run.node.automatic_attrs['platform_family'] = 'debian'
    chef_run.node.automatic_attrs['os'] = 'linux'
    chef_run.node.automatic_attrs['lsb'] = { 'codename' => 'squeeze' }
    chef_run.node.set['xenforo'] = { 'name' => 'xentest',
                                     'repository' => 'ssh://git@mygit/somerepo.git',
                                     'repository_plugins' => 'git://test/test.git',
                                     'htdocs' => '/var/www/xentest' }
    chef_run.node.set['apache'] = { 'user' => 'ap-user', 'group' => 'ap-group' }
    chef_run.converge 'xenforo::default'
    chef_run
  }
  
  # it shouldn't do anything at all
end
