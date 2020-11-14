.PHONY: help setup dependencies install validate clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies \
	Vagrantfile \
	vagrant.json \
	validate

dependencies:
	type vagrant
	type ruby
	type virtualbox

install: Vagrantfile vagrant.json
	vagrant up --provision
	vagrant halt # docker without sudo

Vagrantfile:
	vagrant init

vagrant.json: vagrant.sample.json
	cp $< $@

validate:
	vagrant validate

deps/$(shell id -un)/dotfiles: deps
	[ ! -d $@ ] \
		&& git clone git@github.com:$(shell id -un)/dotfiles.git $@ \
		|| (git -C $@ fetch -p && git -C $@ pull origin $$(git -C $@ symbolic-ref --short HEAD))

deps:
	test -d $@ || mkdir $@

clean:
	vagrant destroy --force
	rm vagrant.json
