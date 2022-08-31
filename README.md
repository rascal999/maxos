# NixOS config and dotfiles

My OS config for security testing.

* Over 470 software packages
* ~300 zsh aliases
* Over 280 bookmarks
  * ~50 security podcast links
  * ~30 online lab links
  * ~20 security oriented search engines
* ~200 git repos
* ~170 docker images
* ~30 web applications
* ~25 Firefox extensions
* Text-only offline [Wikipedia](http://localhost:9060/wikipedia_en_all_nopic_2022-01/A/User:The_other_Kiwix_guy/Landing)
* [Jupyter Notebooks](http://localhost:8000/tree?) for pentesting

![NixOS desktop](/resources/screenshots/20220706_nixos.png)

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
./scripts/init.sh
```
