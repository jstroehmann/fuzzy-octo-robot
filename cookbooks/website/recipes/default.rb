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

remote_file "/var/www/html/enchant.js.zip" do
  source "https://github.com/uei/enchant.js-builds/archive/v0.8.2-b.zip"
  action :create_if_missing
end

bash "unzip enchant" do
  cwd "/var/www/html"
  code <<-EOH
    unzip enchant.js.zip
  EOH
end

template '/var/www/html/index.html' do
  owner 'root'
  group 'root'
  mode '0544'
  source 'index.html.erb'
  action :create
end

cookbook_file '/var/www/html/chara1.png' do
  owner 'root'
  group 'root'
  mode '0544'
  source 'chara1.png'
  action :create
end

cookbook_file '/var/www/html/icon0.png' do
  owner 'root'
  group 'root'
  mode '0544'
  source 'icon0.png'
  action :create
end
