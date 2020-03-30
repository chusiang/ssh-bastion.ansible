Ansible Playbooks: SSH Bastion LAB
=========

A Ansible LAB with SSH bastion host (jump).

| Name    | Public IP | Private IP |
|---------|-----------|------------|
| jump    | DHCP      | 172.1.1.10 |
| server1 | Null      | 172.1.1.11 |

SSH:

* Workstion --> jump: OK
* Workstion --> jump --> server1: OK
* Workstion --> server1: No.

Normal ping (not via Ansible):

* Workstion --> jump / Public IP: OK.
* Workstion --> jump / Private IP: No.
* Workstion --> server1 / Private IP: No.

Requirements
------------

1. Vagrant
1. Make

Variables
--------------

```
$ cat group_vars/all.yml
---
# vars file for ssh-bastion.ansible

ssh_remote_user: vagrant
ssh_bastion_private_key: ".vagrant/machines/jump/virtualbox/private_key"
ssh_server1_private_key: ".vagrant/machines/server1/virtualbox/private_key"

ssh_control_persist: 5m
ssh_strict_host_key_checking: "no"
```

Dependencies
------------

None.

Usage
-----

1. Boot the bastion and managed node.

    ```
    # $ vagrant up
    $ make up
    ```

1. Run `setup_control_machine.yml` playbook at local.

    ```
    # $ ansible-playbook setup_control_machine.yml
    $ make init
    ```

1. Run `ping_all.yml` playbook.

    ```
    # $ ansible-playbook ping_all.yml
    $ make ping
    ```

License
-------

MIT

Author Information
------------------

1. [chusiang (Chu-Siang Lai)](https://note.drx.tw)
