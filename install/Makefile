.PHONY: help setup dependencies install test clean
.PHONY: install-deps install-docker install-docker-compose

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies

dependencies:
	which apt
	which lsb_release

install: \
	install-deps \
	install-docker \
	install-docker-compose \
	add-to-docker-group

test:
	which docker
	which docker-compose
	cat /etc/apt/sources.list | grep -F 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable' | grep -E '^deb'
	id vagrant | grep "$$(cat /etc/group | grep '^docker:' | awk -F: '{print $$3}')(docker)"

install-deps: /var/cache/apt
	apt-get update
	apt-get install -y --no-install-recommends \
		ca-certificates \
		software-properties-common \
		apt-transport-https \
		gnupg-agent \
		curl
	apt-get clean
	rm -rf /var/lib/apt/lists/*

install-docker: /var/cache/apt
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	apt-key fingerprint 0EBFCD88
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable"
	apt-get update
	apt-get install -y --no-install-recommends \
		docker-ce \
		docker-ce-cli \
		containerd.io
	apt-get clean
	rm -rf /var/lib/apt/lists/*

install-docker-compose: \
	/usr/local/bin/docker-compose

/usr/local/bin/docker-compose:
	curl -sL "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose

add-to-docker-group:
	gpasswd -a vagrant docker

clean:
