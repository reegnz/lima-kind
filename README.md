# lima + kind kubernetes dev setup on MacOS

## Tools used

- [lima](https://github.com/lima-vm/lima)
- [kind](https://kind.sigs.k8s.io)

## Getting started

Install dependencies:

```bash
brew bundle -v
```

Note: jinja2-cli from homebrew doesn't have yaml support yet.
See https://github.com/Homebrew/homebrew-core/pull/99105

Until that PR is merged, install jinja2-cli with pipx:

```bash
pipx install 'jinja2-cli[yaml,toml,xml]'
```

Install socket_vmnet.

See install instructions in https://github.com/lima-vm/socket_vmnet,
should be something like this:

```bash
git clone https://github.com/lima-vm/socket_vmnet.git
cd socket_vmnet
sudo make PREFIX=/opt/socket_vmnet install
limactl sudoers | sudo tee /etc/sudoers.d/lima
```

## Launching everything

Just run the default make target in the repo root.

```bash
make
```
