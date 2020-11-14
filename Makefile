.PHONY: help setup dependencies install validate clean

UNAME ?= $(shell id -un)

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies \
	Vagrantfile \
	deps/dotfiles \
	validate

dependencies:
	type vagrant
	type ruby
	type virtualbox

install: Vagrantfile
	vagrant up --provision
	vagrant halt # for docker without sudo

Vagrantfile:
	vagrant init

validate:
	vagrant validate

deps/dotfiles: deps
	[ ! -e $@ ] && (test -e ~/dotfiles && ln -sfnv $_ $@ || mkdir $@)

deps:
	test -d $@ || mkdir $@

clean:
	rm -rf deps

wreck:
	vagrant destroy --force
	$(MAKE) clean
