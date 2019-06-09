# Apache Server Notes:
## Modify access:
+ In Centos, `$ vi /etc/httpd/conf/httpd.conf`  
```
<Directory "/var/www/html">
    AllowOverride All
    Allow from all
</Directory>
```
+ At your own Web directory, e.g. "/var/www/html", create .htaccess to override the access rule.  

## Rewrite rule
+ Load RewriteEngine.