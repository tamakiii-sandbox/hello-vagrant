.PHONY: help setup dependencies build clean

export PACKER_LOG := 0

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies

dependencies:
	type packer

build: packer.json
	packer build $<

download:
	vagrant box add hashicorp/bionic64 --provider virtualbox

list:
	vagrant box list

clean:

