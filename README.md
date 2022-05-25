# lima + kind kubernetes dev setup on MacOS

## Tools used

- [lima](https://github.com/lima-vm/lima)
- [kind](https://kind.sigs.k8s.io)

## Getting started

Install dependencies:

```bash
brew bundle -v
```

Install vde_vmnet and vde-2.

See install instructions in https://github.com/lima-vm/vde_vmnet,
should be something like this:

```bash
git clone https://github.com/lima-vm/vde_vmnet
cd vde_vmnet
git config --global --add safe.directory "$PWD"
make PREFIX=/opt/vde
sudo make PREFIX=/opt/vde install.bin install.vde-2
limactl sudoers | sudo tee /etc/sudoers.d/lima
```


## Launching everything

Just run the default make target in the repo root.

```bash
make
```
