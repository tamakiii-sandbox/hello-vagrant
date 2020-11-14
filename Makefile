.PHONY: help setup dependencies install validate clean

UNAME ?= $(shell id -un)

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies \
	Vagrantfile \
	deps/dotfiles \
	.env \
	validate

dependencies:
	type vagrant
	type ruby
	type virtualbox

install: Vagrantfile
	vagrant plugin install vagrant-env
	vagrant up --provision
	vagrant halt # for docker without sudo

Vagrantfile:
	vagrant init

validate:
	vagrant validate

.env:
	touch $@
	echo "HOST_PORT_HTTP=80" >> $@
	echo "HOST_PORT_HTTPS=443" >> $@
	echo "HOST_PORT_MYSQL=3306" >> $@
	echo "VM_MEMORY=2048" >> $@
	echo "SYNCED_FOLDER=." >> $@
	echo "SYNCED_FOLDER_GUEST=/mnt/shared" >> $@
	echo "GITHUB_PERSONAL_ACCESS_TOKEN=" >> $@

deps/dotfiles: deps
	[ ! -e $@ ] && (test -e ~/dotfiles && ln -sfnv ~/dotfiles $@ || mkdir $@)

deps:
	test -d $@ || mkdir $@

clean:
	rm -rf deps

wreck:
	vagrant destroy --force
	$(MAKE) clean
