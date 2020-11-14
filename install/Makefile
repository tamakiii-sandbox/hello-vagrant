.PHONY: help setup dependencies install test clean
.PHONY: install-deps install-locales install-docker-repo install-docker install-docker-compose
.PHONY: apt-update add-to-docker-group apt-clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies

dependencies:
	which apt
	which lsb_release

install: \
	apt-update \
	install-deps \
	install-locales \
	install-utilities \
	install-docker-repo \
	apt-update \
	install-docker \
	install-docker-compose \
	add-to-docker-group

test:
	which docker
	which docker-compose
	cat /etc/apt/sources.list | grep -F 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable' | grep -E '^deb'
	id vagrant | grep "$$(cat /etc/group | grep '^docker:' | awk -F: '{print $$3}')(docker)"

apt-update:
	apt-get update

apt-clean:
	apt-get clean
	rm -rf /var/lib/apt/lists/*

install-deps:
	apt-get install -y --no-install-recommends \
		ca-certificates \
		software-properties-common \
		apt-transport-https \
		gnupg-agent \
		curl

install-locales:
	apt-get install -y --no-install-recommends locales
	echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen
	echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
	locale-gen ja_JP.UTF-8
	locale-gen en_US.UTF-8

install-utilities:
	apt-get install -y --no-install-recommends \
		zsh \
		fish \
		tcsh

install-docker-repo:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	apt-key fingerprint 0EBFCD88
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable"

install-docker:
	apt-get install -y --no-install-recommends \
		docker-ce \
		docker-ce-cli \
		containerd.io

install-docker-compose: \
	/usr/local/bin/docker-compose

/usr/local/bin/docker-compose:
	curl -sL "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose

add-to-docker-group:
	gpasswd -a vagrant docker

clean:
