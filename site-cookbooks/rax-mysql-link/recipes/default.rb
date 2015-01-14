link '/var/run/mysqld/mysqld.sock' do
  to default['rax']['mysql_sock']
end
