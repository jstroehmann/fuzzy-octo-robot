package "httpd" do
  action :install
end

package "php" do
  action :install
end

service "httpd" do
  action :enable
end

file '/var/www/html/phpinfo.php' do
  owner 'root'
  group 'root'
  mode '0544'
  content '<?php phpinfo(); ?>'
  action :create
end

template '/var/www/html/index.html' do
  owner 'root'
  group 'root'
  mode '0544'
  source 'index.html.erb'
  action :create
end
