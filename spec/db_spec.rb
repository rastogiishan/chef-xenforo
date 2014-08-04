require 'chefspec'

describe 'xenforo::db' do
  let (:chef_run) {
    Chef::Recipe.any_instance.stub(:search).with(:node, 'roles:xenforo AND tags:id-xentest').and_return([{'ipaddress' => '4.3.2.1'}])
    Chef::EncryptedDataBagItem.stub(:load).with('xenforo', 'mysql').and_return({ 'root' => 'rootpw' })
    Chef::EncryptedDataBagItem.stub(:load).with('xenforo', 'db').and_return({ 'xentest' => { 'dbname' => 'testdb',
                                                                                             'username' => 'testuser',
                                                                                             'password' => 'testpw' } })
    chef_run = ChefSpec::ChefRunner.new
    chef_run.node.automatic_attrs['platform_family'] = 'debian'
    chef_run.node.automatic_attrs['os'] = 'linux'
    chef_run.node.automatic_attrs['lsb'] = { 'codename' => 'squeeze' }
    chef_run.node.set['mysql'] = { 'bind_address' => "4.3.2.1" }
    chef_run.node.set['xenforo'] = { 'name' => 'xentest' }
    chef_run.converge 'xenforo::db'
    chef_run
  }

  it 'should check mysql_database' do
    pending "Have no idea how it's done"
  end
  it 'should check mysql_database_user' do
    pending "Have no idea how it's done"
  end
end
