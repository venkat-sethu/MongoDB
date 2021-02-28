



#######################
#general
######################
default['mongodb']['version']="4.0.10"
default['mongodb']['repo_directory']="/NFS"
default['mongodb']['NFS_ip']="192.168.128.70"
default['mongodb']['user']="mongod"
default['mongodb']['group']="mongod"
default['mongodb']['install_method']="rpm"
case node['platform']
when 'redhat'
###############################
#attributes for linux
################################
#
default['mongodb']['base_directory']="/mongo"
default['mongodb']['install_directory']="/NFS/DSTInstall/mongodb_#{node['mongodb']['version']}"
default['mongodb']['mongos-file_name']="#{node['mongodb']['install_directory']}/mongodb-enterprise-mongos-#{node['mongodb']['version']}-1.e17.x86_64.rpm"
default['mongodb']['shell-file_name']="#{node['mongodb']['install_directory']}/mongodb-enterprise-shell-#{node['mongodb']['version']}-1.e17.x86_64.rpm"
default['mongodb']['server-file_name']="#{node['mongodb']['install_directory']}/mongodb-enterprise-server-#{node['mongodb']['version']}-1.e17.x86_64.rpm"
default['mongodb']['tools-file_name']="#{node['mongodb']['install_directory']}/mongodb-enterprise-tools-#{node['mongodb']['version']}-1.e17.x86_64.rpm"
when 'windows'
##########################
#attributes for Windows
#########################
default['mongodb']['install_directory']="C:/mongodb"
default['mongodb']['file_name']= "mongodb-win32-x86_64-2008plus-ssl-#{node['mongodb']['version']}-signed.msi"
default['mongodb']['windows_file_name']="mongo.msi"
end
###########################
#config attributes
##########################
#general

default['mongodb']['config_port']="27017"
default['mongodb']['bind_ip']="0.0.0.0"
case node['platform']
when 'redhat'
##################
####linux_specific
###################
default['mongodb']['conf_file']="/etc/mongod.conf"
default['mongodb']['log_path']="/mongo_logs"
default['mongodb']['data_path']="/mongo_data"
default['mongodb']['pidfile_path']="#{node['mongodb']['base_directory']}/mongodb-pid"
default['mongodb']['encryption_keyfile_path']="#{node['mongodb']['base_directory']}/encryption"
default['mongodb']['service_file_path']="/etc/systemd/system/multi-user.target.wants/mongod.service"
when 'windows'
##############################
#Windows_specific
#############################
default['mongodb']['conf_file']= "#{node['mongodb']['windows_directory']}/bin"
default['mongodb']['log_path']= "C:/data/log"
default['mongodb']['data_path']= "C:/data/db"
default['mongodb']['pidfile_path']= "C:/data"
end
