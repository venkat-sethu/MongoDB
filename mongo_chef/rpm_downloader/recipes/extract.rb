property :path, String, name_property: true

action :install do
	rpm_package new_resource.path do
	action :install
end

action :remove do
	rpm_package new_resource.path do
	action :remove
end
