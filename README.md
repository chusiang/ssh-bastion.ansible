Ansible Playbooks: SSH Bashtion LAB
=========

A Ansible LAB with SSH bashtion host.

Requirements
------------

1. Vagrant
1. Make

Variables
--------------

```
$ cat group_vars/all.yml
---
# vars file for ssh-bashtion.ansible

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

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

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
