> Give me six hours to chop down a tree and I will spend the first four sharpening the ax.

Abraham Lincoln

# What?

[NixOS](https://nixos.org/) config geared towards pentesters and security researchers.

# Why?

TL;DR - This VM/build will probably be useful for exams and people interested in security research.

The goal of this [NixOS](https://nixos.org/) config is to bundle as many tools/aliases/bookmarks as possible to make my pentesting life easier. I never invested the time to really customise my base installation because these customisations were not easily or consistently portable. I didn't want to invest the time customising a machine, getting used to the customisations, and then having to tweak a new build to get to the same place. This all changed when I discovered [NixOS](https://nixos.org/). Now I can customise to my heart's content (almost) and deploy these customisations on any device.

My quest to divorce the data from the tin continues..

# Highlights

This NixOS config comes with a few things to make my life easier while pentesting.

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

All available [here](/config/zsh/zshrc.zsh) (and more).

## localhost.run filebrowser

Deploy externally accessible, web-based file browser in one command.

![a-localhostrun-filebrowser](/resources/gifcap/gifcap-a-localhostrun-filebrowser.gif)

## localhost.run nginx

Deploy externally accessible, web-based nginx instance in one command.

![a-localhostrun-filebrowser](/resources/gifcap/gifcap-a-localhostrun-nginx.gif)

## Vulnerable labs

Deploy a vulnerable lab in one command.

![d-lab-start](/resources/gifcap/gifcap-d-lab-start.gif)

## Ubuntu docker image and port

Deploy an Ubuntu docker image with an arbitrary port exposed in one command.

![d-shellhereport](/resources/gifcap/gifcap-d-shellhereport.gif)

## One line SMB server in CWD

Deploy a SMB share of the current working directory in one command.

![d-smbservehere](/resources/gifcap/gifcap-d-smbservehere.gif)

## Tor array

Deploy a Tor array (a arbitrary number of docker instances which all connect to the Tor network individually and expose incrementing ports) in one command.

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
