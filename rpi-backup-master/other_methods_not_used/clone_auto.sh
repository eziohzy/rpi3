#!/usr/bin/expect -f 
set password 123456

spawn sudo rpi-clone sda
set timeout 300
expect "[sudo] passwd for ezio:"
set timeout 300
send "$password\r"
set timeout 300
send "yes\r"
set timeout 500
expect "Do you want to initialize the destination disk /dev/sda?(yes/no):"
send "yes\r"
