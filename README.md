# hello-vagrant

## How to use
```sh
make -f vagrant.mk setup install
vagrant up
vagrant ssh
vagrant halt
```
```sh
make -f vagrant.mk clean
```

## Variables
```sh
HOST_PORT=8888 \
VM_MEMORY=$(echo '16 * 1024' | bc -l) \
SYNCED_FOLDER=~/Sites \
SYNCED_FOLDER_GUEST=/tmp \
vagrant up
```
