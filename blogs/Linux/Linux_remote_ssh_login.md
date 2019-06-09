# Linux remot ssh login
1. In remote Linux system, `$ vi /etc/ssh/sshd_config`
2. Set:
``` vim
Port 22
PermitRootLogin yes
PasswordAuthentication yes
```
3. `$ ssh-keygen`
4. `$ ssh-copy-id <$username>@<$IP_addr>`
> e.g. `$ ssh root@192.168.2.32`
5. Enter password of <username> in remote Linux.
