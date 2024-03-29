# -*- mode: ruby -*-
# vi: set ft=ruby :
# frozen_string_literal: true

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  config.env.enable

  HOST_PORT_HTTP = (ENV['HOST_PORT_HTTP'] || 80).to_i
  HOST_PORT_HTTPS = (ENV['HOST_PORT_HTTPS'] || 443).to_i
  HOST_PORT_MYSQL = (ENV['HOST_PORT_MYSQL'] || 3306).to_i
  VM_MEMORY = (ENV['VM_MEMORY'] || 2048).to_i
  SYNCED_FOLDER = ENV['SYNCED_FOLDER'] || '.'
  SYNCED_FOLDER_GUEST = ENV['SYNCED_FOLDER_GUEST'] || '/mnt/shared'

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = 'hashicorp/bionic64'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network 'forwarded_port', guest: 80, host: HOST_PORT
  config.vm.network 'forwarded_port', guest: HOST_PORT_HTTP, host: 80
  config.vm.network 'forwarded_port', guest: HOST_PORT_HTTPS, host: 443
  config.vm.network 'forwarded_port', guest: HOST_PORT_MYSQL, host: 3306

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder SYNCED_FOLDER, SYNCED_FOLDER_GUEST, owner: 'vagrant', group: 'vagrant'

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  config.vm.provider 'virtualbox' do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = VM_MEMORY
  end

  # View the documentation for the provider you are using for more
  # information on available options.
  if File.file?('~/dotfiles') do
    config.vm.provision 'shell', inline: 'rm -rf /home/vagrant/dotfiles'
    config.vm.provision 'file', source: '~/dotfiles', destination: '/home/vagrant/dotfiles'
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision 'file', source: './install', destination: '/tmp/install'
  config.vm.provision 'shell', inline: <<-SHELL
    set -ex
    make -C /tmp/install setup
    make -C /tmp/install install
    make -C /tmp/install test
    rm -rf /tmp/install
  SHELL

  config.vm.provision 'shell', inline: <<-SHELL
    git config --global github.accesstoken #{ENV['GITHUB_PERSONAL_ACCESS_TOKEN']}
  SHELL

  config.vm.provision 'shell', inline: <<-SHELL
    set -ex
    test -f /home/vagrant/dotfiles/install.sh && sudo -i -u vagrant $_ || true
    test -f /home/vagrant/dotfiles/Makefile && sudo -i -u vagrant make -C $(dirname $_) install test || true
  SHELL
end
