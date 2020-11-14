# hello-vagrant

## How to use
```sh
make setup install
cat vagrant.json
vagrant up
vagrant ssh
vagrant halt
```
```sh
make clean
```

## Cloning your dotfiles
```sh
make deps/$(id -un)/dotfiles
ls -la deps/$(id -un)/dotfiles
```
