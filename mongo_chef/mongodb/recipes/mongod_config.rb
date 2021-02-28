

# Cookbook:: mongodb
# Recipe:: mongo_config.rb
# Copyright:: 2019, Venkatraman, All Rights Reserved
case node['platform']
when 'redhat'
	cookbook_file "#{node['mongodb']['encryption_keyfile_path']}/encryption_key" do
				 source 'mongodb-keyfile'
				 owner 'mongod'
				 group 'mongod'
				 mode '0600'
				 action :create
			 end

	template "#{node['mongodb']['service_file_path']}" do   #This will store the service file to the config directory
                source 'mongod.service.erb'
		notifies :run, 'execute[daemon reload]', :immediately
        end
	execute "daemon reload" do
		command 'systemctl daemon-reload'
		action :nothing
	end
	template "#{node['mongodb']['conf_file']}" do   #This will store the config file to the config directory
                source 'mongod_standalone.conf.erb'
                notifies :restart, 'service[mongod]', :immediately
        end

        if ! File.exist? "#{node['mongodb']['pidfile_path']}/mongod.pid"
     		service 'mongod' do
     			action :start
     		end
        else
        puts"Mongod Server is already running"
        end
when 'windows'
  	template "#{node['mongodb']['conf_file']}/mongod.conf" do   #This will store the config file to the config directory
    		source 'mongod.conf.erb'
   		 variables(
      		 host_name: node[:hostname],
    		)
         end

  	execute 'Starting mongod with mongo.conf file' do
		action :run
       		 cwd node['mongodb']['conf_file']
       		 command " mongod.exe --config mongod.conf" #this is the command to run mongod server with config file
 		 end
end
