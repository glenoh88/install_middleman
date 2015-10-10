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
#template '/etc/apache2/sites-enabled/blog.conf' do
#  source 'blog.conf.erb'
#end

#workaround for NoMethodError: template
execute 'copy blog.conf' do
  command 'cp -u ~/chef-repo/cookbooks/install_middleman/templates/default/blog.conf.erb /etc/apache2/sites-enabled/blog.conf'
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

#Install git-core
execute 'Install git' do
  command 'apt-get -y install git'
end

#reset and clear repo
execute 'delete repo' do
  command 'rm -r ~/chef-repo/middleman-blog'
end

#clone repo
execute 'clone repo' do
  command  'git clone https://github.com/learnchef/middleman-blog.git'
end

#goto folder
execute 'goto middleman-blog' do
  command 'cd ~/chef-repo/middleman-blog'
end

# Install thin service
execute 'thin install' do
  command 'thin install'
end

#config thin defaults
execute 'thin defaults' do
  command '/usr/sbin/update-rc.d -f thin defaults'
end

#workaround for NoMethodError: template
execute '/etc/thin/blog.conf' do
  command 'cp -u ~/chef-repo/cookbooks/install_middleman/templates/default/blog.yml.erb /etc/init.d/thin/blog.conf'
end
