# ansible-role-wsusoffline

Ansible role to download wsus offline patches for windows x64 bits versions. With the help off WSUS Offline Update.

Read more about the tool on --> https://www.wsusoffline.net/

## how to use
```bash
# start box
$ vagrant up

# provision box with ansible
$ vagrant provision

```

## todo
- [ ] update blacklist
- [ ] copy c:\wsus_update folder to network share
- [ ] install update

```bat
:: install updates
C:\Windows\system32\cmd.exe  /K DoUpdate.cmd  /updatercerts /showlog
```
