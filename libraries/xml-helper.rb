# Ensure the xml/mapping gem is installed and available
begin
  require 'xml/mapping'
rescue LoadError
  run_context = Chef::RunContext.new(Chef::Node.new, {}, Chef::EventDispatch::Dispatcher.new)
  chef_gem = Chef::Resource::ChefGem.new("xml-mapping", run_context)
  chef_gem.version('>= 0.9')
  chef_gem.run_action(:install)
end
