# hello-vagrant

## How to use
```sh
make setup install
vagrant up
vagrant ssh
vagrant halt
```
```sh
make clean
make wreck
```

## Using shared folder
```sh
SYNCED_FOLDER=directory vagrant up
ls -la /mnt/shared
```

## Specifying memory size
```sh
VM_MEMORY=$(echo '12 * 1024' | bc -l) vagrant up
```

## Specifying ports
```sh
HOST_PORT_HTTP=8080 \
HOST_PORT_HTTPS=4443 \
HOST_PORT_MYSQL=6606 \
vagrant up
```

## Cloning your dotfiles
```sh
UNAME=your-github-name make setup
ls -la deps/dotfiles
```
