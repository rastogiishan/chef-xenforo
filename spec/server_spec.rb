require 'chefspec'

def get_host(url)
  a = url.index('@') + 1
  return url[a, url[a, url.size - 1].index('/')]
end

describe 'xenforo::server' do
  let(:chef_run) {
    File.stub(:exists?).with('/root/.ssh/host_added_mygit').and_return(true)
    Chef::Recipe.any_instance.stub(:search).with(:node, 'roles:xenforodb AND tags:id-xentest').and_return([{'ipaddress' => '1.2.3.4', 'mysql' => { 'port' => '56' } }])
    Chef::Recipe.any_instance.stub(:search).with(:node, 'roles:xenforomem AND tags:id-xentest').and_return([{'ipaddress' => '2.3.4.5', 'memcached' => { 'port' => '777' } }])
    Chef::EncryptedDataBagItem.stub(:load).with('xenforo', 'ssh').and_return({
                                                             'root' => { 'secretkey' => 'mysecret',
                                                                         'publickey' => 'mypublic' },
                                                             'addons' => { 'secretkey' => 'addonssecret',
                                                                           'publickey' => 'addonspublic' } })
    Chef::EncryptedDataBagItem.stub(:load).with('xenforo', 'db').and_return({ 'xentest' => { 'dbname' => 'testdb',
                                                                                             'username' => 'testuser',
                                                                                             'password' => 'testpw' } })
    chef_run = ChefSpec::ChefRunner.new
    chef_run.node.automatic_attrs['platform_family'] = 'debian'
    chef_run.node.automatic_attrs['os'] = 'linux'
    chef_run.node.automatic_attrs['lsb'] = { 'codename' => 'squeeze' }
    chef_run.node.set['xenforo'] = { 'name' => 'xentest',
                                     'instance' => '01',
                                     'repository' => 'ssh://git@mygit/somerepo.git',
                                     'repository_plugins' => 'git://test/test.git',
                                     'htdocs' => '/var/www/xentest' }
    chef_run.node.set['apache'] = { 'user' => 'ap-user', 'group' => 'ap-group' }
    chef_run.converge 'xenforo::server'
    chef_run
  }
  before(:each) {
    File.stub(:exists?).and_call_original
  }

  it 'includes apache2-wrapper::default' do
    expect(chef_run).to include_recipe 'apache2-wrapper::default'
  end

  it 'includes _apache' do
    expect(chef_run).to include_recipe "#{described_cookbook}::_apache"
  end

  ['git', 'php5-mysql', 'php5-gd'].each do |pkg|
    it 'installs ' + pkg do
      expect(chef_run).to install_package pkg
    end
  end

  it 'ssh files and directories' do
    directory = chef_run.directory('/root/.ssh')
    expect(directory).to be_owned_by('root')
    expect(directory.mode).to eq('0700')
    file = chef_run.file('/root/.ssh/id_rsa')
    expect(file).to be_owned_by('root')
    expect(file.mode).to eq('0600')
    expect(file.content).to eq('mysecret')
    file = chef_run.file('/root/.ssh/id_rsa.pub')
    expect(file).to be_owned_by('root')
    expect(file.mode).to eq('0644')
    expect(file.content).to eq('mypublic')
  end

  it 'add group' do
    expect(chef_run).to create_group chef_run.node['xenforo']['htdocs_group']
  end

  it 'adding to known hosts' do
    [chef_run.node['xenforo']['repository'], chef_run.node['xenforo']['repository_plugins']].each do |url|
      if url.start_with?('ssh') || url.start_with?('git+ssh')
        a = url.index('@') + 1
        host = get_host(url)
        expect(chef_run).to execute_bash_script 'add_to_known_hosts'
      end
    end
  end

  it 'Create directories for the git ceckouts' do
    [chef_run.node['xenforo']['repository_destination'], chef_run.node['xenforo']['repository_addons_destination']].each do |dir|
      directory = chef_run.directory(dir)
      expect(directory).to be_owned_by('root', chef_run.node['apache']['group'])
      expect(directory.mode).to eq('0755')
    end
  end

  it 'should check if git is synced' do
    pending "Have no idea how it\'s done"
    expect(chef_run.find_resource('git', chef_run.node['xenforo']['repository_destination'])).to nofify 'file[#{ctag}]', :create
    expect(chef_run.find_resource('git', chef_run.node['xenforo']['repository_addons_destination'])).to nofify 'file[#{ctag}]', :create
  end

  it 'merging into htdocs' do
    expect(chef_run).to execute_bash_script 'merge_repositories_into_htdocs'
  end

  it 'search dbs ip and port' do
    expect(chef_run).to log 'Found DB on 1.2.3.4:56'
  end

  it 'create config' do
    expect(chef_run).to create_file_with_content "#{chef_run.node['xenforo']['htdocs']}/library/config.php", "$config['db']['host'] = '1.2.3.4';"
    expect(chef_run).to create_file_with_content "#{chef_run.node['xenforo']['htdocs']}/library/config.php", "$config['db']['port'] = '56';"
    expect(chef_run).to create_file_with_content "#{chef_run.node['xenforo']['htdocs']}/library/config.php", "$config['db']['username'] = 'testuser';"
    expect(chef_run).to create_file_with_content "#{chef_run.node['xenforo']['htdocs']}/library/config.php", "$config['db']['password'] = 'testpw';"
    expect(chef_run).to create_file_with_content "#{chef_run.node['xenforo']['htdocs']}/library/config.php", "$config['db']['dbname'] = 'testdb';"
    expect(chef_run).to create_file_with_content "#{chef_run.node['xenforo']['htdocs']}/library/config.php", "$config['acpSuffix'] = 'xentest';"
    expect(chef_run).to create_file_with_content "#{chef_run.node['xenforo']['htdocs']}/library/config.php", "'host' => '2.3.4.5',"
    expect(chef_run).to create_file_with_content "#{chef_run.node['xenforo']['htdocs']}/library/config.php", "'port' => 777"
  end
  
  it 'maintainance' do
    directory = chef_run.directory(chef_run.node['xenforo']['htdocs_maintenance'])
    expect(directory.mode).to eq('0755')
    expect(chef_run).to create_file_with_content "#{chef_run.node['xenforo']['htdocs_maintenance']}/index.html", '<!DOCTYPE html>'
    expect(chef_run).to create_file_with_content '/usr/sbin/maintenance.sh', "if [ \"$1\" == \"enable\" ]"
  end
end
