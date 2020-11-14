# hello-vagrant

## How to use
```sh
make -f vagrant.mk setup install
cat vagrant.json
vagrant up
vagrant ssh
vagrant halt
```
```sh
make -f vagrant.mk clean
```

## Cloning your dotfiles
```sh
make -f vagrant.mk deps/$(id -un)/dotfiles
ls -la deps/$(id -un)/dotfiles
```
