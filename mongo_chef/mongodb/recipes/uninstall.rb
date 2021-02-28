# Cookbook:: mongodb
# Recipe:: uninstall.rb
#
# Copyright:: 2019, Venkatraman , All Rights Reserved
case node['platform']
when 'redhat'
        if ! File.exist? "#{node['mongodb']['pidfile_path']}/mongod.pid"
	service 'mongod' do
         	action :stop
	end
	else
	puts"Mongod Server is not running in backgroung and all good to unintsall"
	end
	rpm_package "#{node['mongodb']['install_directory']}/#{node['mongodb']['file_name']}" do
		action :remove
	end
##################################
#This will delete log data Pid file and mongodb download directory
##################################
	dir1 =node['mongodb']['log_path']
	dir2 =node['mongodb']['data_path']
#	dir3 =node['mongodb']['install_directory']
	dir4 =node['mongodb']['base_directory']
#	dir5 =node['mongodb']['pidfile_path']
#	dir6 =node['mongodb']['encryption_keyfile_path']
	%W{#{dir1} #{dir2}  #{dir4}}.each do |dir|
        	directory dir  do
	       	   owner 'root'
	           group 'root'
	           action :delete
	           recursive true
	        end
	end

	#file node['mongodb']['conf_file'] do  #This will delete the config file of mongodb
       # 	action :delete
#	        owner 'root'
#	        group 'root'
#	end

when 'windows'
	install_path =node['mongodb']['install_directory']
	log_path =node['mongodb']['log_path']
	data_path =node['mongodb']['data_path']
	pid_file =node['mongodb']['pidfile_path']
	%W{#{log_path} #{data_path} #{pid_file} #{install_path} }.each do |dir|
		  directory dir do
		     action :delete
		     recursive true
		  end
	end
end
