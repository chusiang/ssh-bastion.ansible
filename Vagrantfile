# -*- mode: ruby -*-

# Network connection:
#
#   Workstion --> jump: OK
#   Workstion --> jump --> server1: OK
#   Workstion --> server1: No.

# Maybe we need modify this variable for different network environment.
BRIDGE_INTERFACE = "en4: Thunderbolt Ethernet"

DOMAIN = "ssh-bashtion.local"

instances = [
  {
    :name       => "jump",
    :image      => "ubuntu/bionic64",
    :public_net => true,
    :private_ip => "172.1.1.11"
  },
  {
    :name       => "server1",
    :image      => "ubuntu/bionic64",
    :public_net => false,
    :private_ip => "172.1.1.12"
  }
]

# Main
######

Vagrant.configure("2") do |config|

  # Loop by each.
  instances.each do |instance|

    config.vm.define instance[:name] do |node|
      node.vm.box = instance[:image].to_s

      # hostname = <instance name>.<DOMAIN>
      node.vm.hostname = instance[:name].to_s + "." + DOMAIN

      node.vm.provider "virtualbox" do |vb|
        vb.linked_clone = true
      end

      # Bridge network. (Jump box only)
      if ( instance[:public_net] == true )
        node.vm.network "public_network",
          type: "dhcp",
          bridge: [ BRIDGE_INTERFACE ]
      end

      # Internal network.
      node.vm.network "private_network",
        ip: instance[:private_ip],
        virtualbox__intnet: true

      node.vm.provision "shell",
        inline: "echo 'set -o vi' >> /etc/bash.bashrc"

      # node.vm.provision "ansible" do |ansible|
      #   ansible.playbook = "setup.yml"
      #   ansible.become = true
      # end
    end

  end
end

# vi: set ft=ruby :
