# Centos apache deploy
1. Install httpd.
> `$ yum install httpd`
2. Modify httpd.conf file.
> `$ vi /etc/httpd/conf/httpd.conf`
>> Listen 80  
>> ServerName localhost:80  
3. Open port 80.
> `$ firewall-cmd --zone=public --add-port=80/tcp --permanent`  
> `$ firewall-cmd --reload`  
