#!/bin/sh

# MySQL
brew install mysql

# mysql_secure_installation automated
mysql.server start

expect<<EOF
set timeout 2
spawn mysql_secure_installation
expect "Press y|Y for Yes, any other key for No:"
send "n\r"
expect "New Password:"
send_user "After New"
send "$mysql_root_password\r"
expect "Re-enter new password:"
send "$mysql_root_password\r"
expect "Remove anonymous users? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect "Disallow root login remotely? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect "Remove test database and access to it? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect "Reload privilege tables now? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect eof
EOF

mysql.server stop
