#
# Cookbook Name:: install_middleman
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#Update apt-get
execute 'Update apt-get' do
  command 'apt-get update'
end

#Get Ruby dependencies
execute 'Get ruby dependencies' do
  command 'apt-get -y install build-essential libssl-dev libyaml-dev libreadline-dev openssl curl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev nodejs libsqlite3-dev sqlite3
'
end

#execute "Make Ruby directories" do
#  command "mkdir ~/ruby"
#  ignore_failure true
#  not_if do ::File.exists?('/usr/bin/ruby') end
#end

#Install Ruby
execute 'Install ruby' do
  command 'apt-get -y install ruby-full'
end

#Copy ruby to /usr/bin/
execute 'copy ruby to /usr/bin/' do
  command 'cp /usr/local/bin/ruby /usr/bin/ruby'
  ignore_failure true
  not_if do ::File.exists?('/usr/bin/ruby') end
end

#Copy gem to /usr/bin/
execute 'copy gem to /usr/bin/' do
  command 'cp /usr/local/bin/gem /usr/bin/gem'
  ignore_failure true
  not_if do ::File.exists?('/usr/bin/gem') end
end

#Install apache
execute 'Install ruby' do
  command 'apt-get -y install apache2'
end

#start apache
service 'apache2' do
  supports :status => true
  action [:enable, :start]
end

#enable some apache modules
execute 'a2enmod' do
  command 'a2enmod proxy_http rewrite '
end

#configure blog.conf
template '/etc/apache2/sites-enabled/blog.conf' do
  source 'blog.conf.erb'
end

#delete /etc/apache2/sites-enabled/000-default.conf
file '/etc/apache2/sites-enabled/000-default.conf' do
  action :delete
end

#restart apache
service 'apache2' do
  supports :status => true
  action :restart
end
