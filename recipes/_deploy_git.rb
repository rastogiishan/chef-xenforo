# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Bigpoint xenForo forum
# Recipe::              _deploy_git.rb
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

SSH_HOSTS_PREFIX = '/root/.ssh/host_added_'

def get_host(url)
  a = url.index('@') + 1
  url[a, url[a, url.size - 1].index('/')]
end

[node['xenforo']['repository'], node['xenforo']['repository_addons']].each do |url|
  if url.start_with?('ssh') || url.start_with?('git+ssh')
    host = get_host(url)
    unless File.exist?("#{SSH_HOSTS_PREFIX}#{host}")
      bash 'add_to_known_hosts' do
        code <<-EOH
            ssh -o StrictHostKeyChecking=no git@#{host} exit
        EOH
        user 'root'
        ignore_failure true
      end
      file "#{SSH_HOSTS_PREFIX}#{host}" do
        action :create
      end
    end
  end
end

if File.exist?("#{SSH_HOSTS_PREFIX}#{get_host(node['xenforo']['repository'])}")
  [node['xenforo']['repository_destination'],
   node['xenforo']['repository_addons_destination']].each do |dir|
    directory dir do
      owner 'root'
      group node['apache']['group']
      mode '0755'
      recursive true
      action :create
    end
  end

  git node['xenforo']['repository_destination'] do
    repository node['xenforo']['repository']
    revision node['xenforo']['repository_revision']
    user 'root'
    group node['apache']['group']
    action :sync
    notifies :create, "file[#{node['xenforo']['repo_changed_file']}]"
  end

  git node['xenforo']['repository_addons_destination'] do
    repository node['xenforo']['repository_addons']
    revision node['xenforo']['repository_addons_revision']
    user 'root'
    group node['apache']['group']
    action :sync
    notifies :create, "file[#{node['xenforo']['repo_changed_file']}]"
  end

  file node['xenforo']['repo_changed_file'] do
    action :nothing
  end

  bash 'merge_repositories_into_htdocs' do
    user 'root'
    environment 'BOARD' => node['xenforo']['repository_destination'],
                'ADDONS' => node['xenforo']['repository_addons_destination'],
                'HT' => node['xenforo']['htdocs_xenforo'],
                'HTOLD' => "#{node['xenforo']['htdocs_xenforo']}-old",
                'HTNEW' => "#{node['xenforo']['htdocs_xenforo']}-new"
    code <<-EOH
        rm -rf $HTNEW $HTOLD
        mkdir $HTNEW && \
        cp -R $BOARD/. $HTNEW/ && \
        cp -R $ADDONS/. $HTNEW/ && \
        (cp -R $HT/data/. $HTNEW/data/; cp -R $HT/internal_data/. $HTNEW/internal_data/; true) && \
        rm -rf $HTNEW/.git $HTNEW/.project $HTNEW/.buildpath $HTNEW/.settings && \
        chgrp -R #{node['xenforo']['htdocs_group']} $HTNEW && \
        chmod -R g+rw $HTNEW && \
        chown -R #{node['apache']['user']} $HTNEW/data $HTNEW/internal_data && \
        mv $HT $HTOLD && \
        mv $HTNEW $HT && \
        rm -rf $HTOLD && \
        rm -f #{node['xenforo']['repo_changed_file']} $HT/library/*.default $HT/README.md
        killall -HUP apache2
    EOH
    notifies :run, 'execute[generate_status_script]', :delayed
    only_if { File.exist?(node['xenforo']['repo_changed_file']) }
    # notifies config.php should not be needed. Changed and should be restored therefor below
  end
end
