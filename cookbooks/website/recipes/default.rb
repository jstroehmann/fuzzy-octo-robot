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
