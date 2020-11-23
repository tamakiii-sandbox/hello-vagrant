.PHONY: help setup dependencies install test clean

export DEBIAN_FRONTEND := noninteractive

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies

dependencies:
	type apt

install:
	apt-get update
	apt-get install -y --no-install-recommends \
		ca-certificates \
		software-properties-common \
		apt-transport-https \
		gnupg-agent \
		curl
	apt-get install -y --no-install-recommends \
		zsh \
		bash \
		fish \
		tcsh

test:
	which zsh

clean:
