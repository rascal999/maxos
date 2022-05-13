# NixOS config and dotfiles

## Install

Use unstable ISO (https://www.google.com/search?q=nixos+iso+unstable) for flake support.

### Get repo

```
# Set SSH key for GitHub
nix-env -i git
git clone git@github.com:rascal999/nixos.git
cd nixos/
```

OR

```
curl -L https://bit.ly/3yCeldM -o master.zip
unzip master.zip
cd nixos-master/
```

### Install

```
./init.sh
```
