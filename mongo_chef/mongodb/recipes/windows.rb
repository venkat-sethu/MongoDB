#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
####################################
#this will create data directory for mongodb
####################################
install_path =node['mongodb']['install_directory']
log_path =node['mongodb']['log_path']
data_path =node['mongodb']['data_path']
pid_file =node['mongodb']['pidfile_path']
%W{#{log_path} #{data_path} #{pid_file} #{install_path} }.each do |dir|
  directory dir do
     action :create
     recursive true
  end
end

url="#{node['mongodb']['repo_url']}/#{node['mongodb']['repo_directory']}/#{node['mongodb']['repo_file_name']}"
###################################
#below code will fetch msi binary from url
###################################
remote_file "#{node['mongodb']['install_directory']}/#{node['mongodb']['file_name']}" do
   source url
   action :create_if_missing
end
####################################
##below command will install mongodb
####################################
execute "cmd" do
   cwd node['mongodb']['install_directory']
   action :run
   command "msiexec.exe /l*v mdbinstall.log  /qb /i #{node['mongodb']['windows_file_name']} INSTALLLOCATION="#{node[:mongodb][:directory]}" "
  end

####################################
#below code will delete the binary
####################################
file "/#{node['mongodb']['install_directory']}/#{node['mongodb']['file_name']}" do
         action :delete
end
 

