.PHONY: help setup dependencies install bash clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies \
	Vagrantfile

dependencies:
	command -v vagrant
	command -v ruby

install:
	vagrant up
	vagrant provision
	vagrant halt # docker without sudo

Vagrantfile:
	vagrant init

clean:
	vagrant destroy --force
