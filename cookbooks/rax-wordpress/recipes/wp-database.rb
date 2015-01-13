# coding: utf-8
#
# Cookbook Name:: rax-wordpress
# Recipe:: wp-database
#
# Copyright 2014
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

unless platform_family?('windows') # No MySQL client on Windows
  mysql_client 'default' do
    action :create
  end
end

db = node['wordpress']['db']

mysql_connection_info = {
  :host     => db['host'],
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database db['name'] do
  connection  mysql_connection_info
  action      :create
end

mysql_database_user db['user'] do
  connection    mysql_connection_info
  password      db['pass']
  host          db['host']
  database_name db['name']
  action        :create
end

mysql_database_user db['user'] do
  connection    mysql_connection_info
  database_name db['name']
  privileges    [:all]
  host          "10.%"
  action        :grant
end
