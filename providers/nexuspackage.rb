# Encoding: UTF-8
require 'net/http'
require 'xml/mapping'
require 'rexml/document'
require 'open-uri'

# Data in the XML object
class AData
  include XML::Mapping
  text_node :present_locally, 'presentLocally'
  text_node :group_id, 'groupId'
  text_node :artifact_id, 'artifactId'
  text_node :version, 'version'
  text_node :classifier, 'classifier', :default_value => ''
  text_node :extension, 'extension'
  text_node :snapshot, 'snapshot'
  text_node :snapshot_build_number, 'snapshotBuildNumber'
  text_node :snapshot_time_stamp, 'snapshotTimeStamp'
  text_node :sha1, 'sha1'
  text_node :repository_path, 'repositoryPath'
end

# The response from nexus
class ArtifactResolution
  include XML::Mapping
  object_node :data, 'data', :class => AData
end

action :update do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  # POM (XML) URL
  url = 'https://'
  # url << "#{new_resource.nexus_username}:#{new_resource.nexus_password}@" unless new_resource.nexus_username.nil?
  url << "#{new_resource.nexus_server}/nexus/service/local/artifact/maven/resolve?g=#{new_resource.groupid}"
  url << "&a=#{new_resource.name}&e=#{new_resource.extension}"

  if new_resource.repository
    url << '&r='
    url << new_resource.repository
  end
  url << '&v='
  url << new_resource.version
  unless new_resource.classifier.empty?
    url << '&c='
    url << new_resource.classifier
  end

  log "Fetching from Nexus: #{url}"

  # *** AUTH ***
  if new_resource.nexus_username.nil?
    nexus_auth = nil
    @xml_data = open(url).read
  else
    nexus_auth = Base64.encode64("#{new_resource.nexus_username}:#{new_resource.nexus_password}").strip
    @xml_data = open(url, :http_basic_authentication=>[new_resource.nexus_username, new_resource.nexus_password]).read
  end
  ar_new = ArtifactResolution.load_from_xml(REXML::Document.new(@xml_data).root)

  # Archive URL
  url = 'https://'
  url << "#{new_resource.nexus_username}:#{new_resource.nexus_password}@" unless new_resource.nexus_username.nil?
  url << "#{new_resource.nexus_server}/nexus/content/repositories/#{new_resource.repository}#{ar_new.data.repository_path}"

  # Definitions
  xml_file = "/var/cache/#{new_resource.name}.xml"
  filename = "#{ar_new.data.artifact_id}.#{ar_new.data.extension}"
  archive = "#{Chef::Config['file_cache_path']}/#{filename}"

  # Compare versions
  if ::File.exist?(xml_file)
    ar_old = ArtifactResolution.load_from_file(xml_file)
    new_resource.updated_by_last_action(ar_old.data.version != ar_new.data.version)
  else
    new_resource.updated_by_last_action(true)
  end

  remote_file archive do
    source url
    backup 0
    headers('Authorization' => "Basic #{nexus_auth}") unless nexus_auth.nil?
    action :create
    notifies :run, "ruby_block[validate_checksum_#{new_resource.name}]", :immediately
    only_if { new_resource.updated_by_last_action? }
  end

  ruby_block "validate_checksum_#{new_resource.name}" do
    block do
      fail 'SHA1 verification failed' unless Digest::SHA1.file(archive).hexdigest == ar_new.data.sha1
    end
    action :nothing
    notifies :create, "directory[#{new_resource.destination}]", :immediately
  end

  directory new_resource.destination do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    action :nothing
    notifies :run, "execute[extract_tgz_#{new_resource.name}]", :immediately
  end

  execute "extract_tgz_#{new_resource.name}" do
    cwd new_resource.destination
    command "tar xzf #{archive} && chown -R #{new_resource.owner}:#{new_resource.group} ."
    action :nothing
    notifies :delete, "file[#{archive}]", :immediately
  end

  file archive do
    action :nothing
    notifies :run, "ruby_block[update_version_#{new_resource.name}]", :immediately
  end

  ruby_block "update_version_#{new_resource.name}" do
    block do
      file = ::File.new(xml_file, 'w')
      file.write(ar_new.save_to_xml)
      file.close
    end
    action :nothing
  end
end
