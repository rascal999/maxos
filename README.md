> Give me six hours to chop down a tree and I will spend the first four sharpening the ax.

Abraham Lincoln

# NixOS config and dotfiles

My OS config for security testing.

* Over 470 software packages
* ~300 zsh aliases
* Over 390 security-focused bookmarks:
  * ~55 podcasts
  * ~40 news resources
  * ~30 online labs
  * ~25 newsletters
  * ~25 YouTube channels
  * ~20 search engines
* ~230 git repos
* ~170 docker images
* ~30 web applications
* ~25 Firefox extensions
* Text-only offline [Wikipedia](http://localhost:9060/wikipedia_en_all_nopic_2022-01/A/User:The_other_Kiwix_guy/Landing)
* [Jupyter Notebooks](http://localhost:8000/tree?) for pentesting

![NixOS desktop](/resources/screenshots/20220706_nixos.png)

# ZSH aliases

All available here (and more).

## localhost.run filebrowser

![a-localhostrun-filebrowser](/resources/gifcap/gifcap-a-localhostrun-filebrowser.gif)

## localhost.run nginx

![a-localhostrun-filebrowser](/resources/gifcap/gifcap-a-localhostrun-nginx.gif)

## Vulnerable labs

![d-lab-start](/resources/gifcap/gifcap-d-lab-start.gif)

## Ubuntu docker image and port

![d-shellhereport](/resources/gifcap/gifcap-d-shellhereport.gif)

## One line SMB server in CWD

![d-smbservehere](/resources/gifcap/gifcap-d-smbservehere.gif)

## Tor array

![d-tor-array](/resources/gifcap/gifcap-d-tor-array.gif)

# Install

Use unstable ISO (https://www.google.com/search?q=nixos+iso+unstable) for flake support.

## Get repo

```
# Set SSH key for GitHub
nix-env -i git
git clone git@github.com:rascal999/maxos.git
cd nixos/
```

OR

```
curl -L https://bit.ly/3yCeldM -o master.zip
unzip master.zip
cd nixos-master/
```

## Install

```
./scripts/init.sh
```
