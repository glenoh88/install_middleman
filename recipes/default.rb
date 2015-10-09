#
# Cookbook Name:: install_middleman
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
execute 'Update apt-get' do
  command 'apt-get update'
end
