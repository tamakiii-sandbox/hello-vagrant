.PHONY: help setup dependencies install test clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies

dependencies:
	which apt

install:
	apt-get update
	apt-get install -y --no-install-recommends \
		zsh
	apt-get clean
	rm -rf /var/lib/apt/lists/*

test:
	which zsh

clean:

