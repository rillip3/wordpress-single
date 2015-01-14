link '/var/run/mysqld/mysqld.sock' do
  to node['rax']['mysql_sock']
end
