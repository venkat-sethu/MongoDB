#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
case node['platform']
when 'redhat'
   if ( node['platform_version'] >= "6.2")
   include_recipe 'mongodb::linux'
   include_recipe 'mongodb::mongod_config'
   else
   	puts "Mongodb cannot be installed in this server.please use RHEL greater than 6.2 version"
   end
when 'windows'
   if ( node['platform_version'] >= "7")||( node['platform_version'] >= "2008R1")
   include_recipe 'mongodb::windows'
   else
   	puts "Mongodb cannot be installed in this server.Please use Windows greater than 7/2008R1"
   end
end

