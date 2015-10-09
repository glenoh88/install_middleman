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
  command 'apt-get install build-essential libssl-dev libyaml-dev libreadline-dev openssl curl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev nodejs libsqlite3-dev sqlite3
'
end
