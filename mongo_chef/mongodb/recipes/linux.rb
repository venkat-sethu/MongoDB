
# Cookbook:: mongodb
# Recipe:: linux.rb
# Copyright:: 2019, Venkatraman, All Rights Reserved

##############################
#create installation directory to mount mongodb binaries
##############################
directory node['mongodb']['install_directory'] do
        action :create
end

###############################
#mount mongodb binaries from NFS server
##############################
url = "#{node['mongodb']['NFS_ip']}:#{node['mongodb']['repo_directory']}"
mount node['mongodb']['repo_directory'] do
         device url
         fstype 'nfs'
         options 'rw'
end
#############################
#below code will check installation method
#############################
case node['mongodb']['install_method']
when'rpm'
	####################################
	#below code will install mongodb through rpm and will create mongod user
	###################################
	server=node['mongodb']['server-file_name']
	mongos=node['mongodb']['mongos-file_name']
	shell=node['mongodb']['shell-file_name']
	tools=node['mongodb']['tools-file_name']
	%W{#{server} #{mongos} #{shell} #{tools}}.each do |packages|
		rpm_downloader_extract packages do
   			action :install
		end
	end
end
####################################
#below code will create mongodb directories
###################################
log_path =node['mongodb']['log_path']
data_path =node['mongodb']['data_path']
base_dir =node['mongodb']['base_directory']
pid_file =node['mongodb']['pidfile_path']
encryption_path =node['mongodb']['encryption_keyfile_path']
%W{#{log_path} #{data_path}  #{base_dir} #{pid_file} #{encryption_path}}.each do |dir|
        directory dir  do
        owner node['mongodb']['user']
        group node['mongodb']['group']
        action :create
        recursive true
        end
end
