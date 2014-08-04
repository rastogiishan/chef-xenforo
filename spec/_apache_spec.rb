require 'chefspec'

describe 'xenforo::_apache' do
  let(:chef_run) {
    chef_run = ChefSpec::ChefRunner.new
    Chef::EncryptedDataBagItem.stub(:load).with('xenforo', 'apache').and_return({ 'cert' => 'mycert',
                                                                                  'certkey' => 'mykey',
                                                                                  'cacert' => 'myca' })
    chef_run.node.automatic_attrs['platform_family'] = 'debian'
    chef_run.node.automatic_attrs['os'] = 'linux'
    chef_run.node.automatic_attrs['lsb'] = { 'codename' => 'squeeze' }
    chef_run.node.set['xenforo'] = { 'name' => 'xentest',
                                     'enable_ssl' => true,
                                     'ssl_public' => '/etc/ssl/certs/test.pem',
                                     'ssl_private' => '/etc/ssl/private/test.key',
                                     'ca_cert' => '/etc/ssl/certs/test-ca.crt' }
    chef_run.converge 'xenforo::_apache'
    chef_run
  }

  it 'Check certificates' do
    if chef_run.node['xenforo']['ssl_private']
      expect(chef_run).to create_file_with_content chef_run.node['xenforo']['ssl_public'], 'mycert'
      file = chef_run.file(chef_run.node['xenforo']['ssl_public'])
      expect(file).to be_owned_by(chef_run.node['apache']['user'], chef_run.node['apache']['group'])
      expect(file.mode).to eq('0644')
      expect(chef_run).to create_file_with_content chef_run.node['xenforo']['ssl_private'], 'mykey'
      file = chef_run.file(chef_run.node['xenforo']['ssl_private'])
      expect(file).to be_owned_by(chef_run.node['apache']['user'], chef_run.node['apache']['group'])
      expect(file.mode).to eq('0600')
      expect(chef_run).to create_file_with_content chef_run.node['xenforo']['ca_cert'], 'myca'
      file = chef_run.file(chef_run.node['xenforo']['ca_cert'])
      expect(file).to be_owned_by(chef_run.node['apache']['user'], chef_run.node['apache']['group'])
      expect(file.mode).to eq('0644')      
    end
  end

  it 'htdocs' do
    directory = chef_run.directory(chef_run.node['xenforo']['htdocs_xenforo'])
    expect(directory).to be_owned_by(chef_run.node['apache']['user'], chef_run.node['apache']['group'])
    expect(directory.mode).to eq('0555')
  end

  it 'php.ini for this project' do
    directory = chef_run.directory("/etc/php5/#{chef_run.node['xenforo']['name']}")
    expect(directory).to be_owned_by('root', 'root')
    expect(directory.mode).to eq('0755')
    expect(chef_run).to create_file_with_content '/etc/php5/' + chef_run.node['xenforo']['name'] + '/php.ini', '[PHP]'
  end

  it 'site' do
    if chef_run.node['xenforo']['enable_ssl']
      content = '<VirtualHost 0.0.0.0:443>'
    else
      content = '<VirtualHost 0.0.0.0:80>'
    end
    expect(chef_run).to create_file_with_content '/etc/apache2/sites-available/maintenance', content
    expect(chef_run).to create_file_with_content '/etc/apache2/sites-available/001-default', content
    expect(chef_run).to create_file_with_content '/etc/apache2/sites-available/xenforo-' + chef_run.node['xenforo']['name'], content
  end  
end
