#!/usr/bin/env bash

# Software packages
SOFTWARE_PACKAGES=`cat config/pkgs_* | grep "# " | wc -l`
sed "s/SOFTWARE_PACKAGES/$SOFTWARE_PACKAGES/g" resources/README.md.template > README.md

# zsh aliases
ZSH_ALIASES=`cat config/zsh/zshrc.zsh | grep "() {" | wc -l`
sed -i "s/ZSH_ALIASES/$ZSH_ALIASES/g" README.md

# git repos (resources.sh)
GIT_REPOS=`git submodule status | wc -l`
sed -i "s/GIT_REPOS/$GIT_REPOS/g" README.md

# docker repos (resources.sh)
DOCKER_REPOS=`cat scripts/resources.sh | grep -E "docker build|docker run|docker pull" | grep -v "#docker" | wc -l`
sed -i "s/DOCKER_REPOS/$DOCKER_REPOS/g" README.md

# Podcasts
PODCASTS=`cat config/firefox/firefox-policies.json | jq '.[].ManagedBookmarks[] | select(.name=="Podcasts") | .children[].url' | wc -l`
sed -i "s/PODCASTS/$PODCASTS/g" README.md

# YouTube
YOUTUBE=`cat config/firefox/firefox-policies.json | jq '.[].ManagedBookmarks[] | select(.name=="YouTube") | .children[].url' | wc -l`
sed -i "s/YOUTUBE/$YOUTUBE/g" README.md

# Online labs
LABS=`cat config/firefox/firefox-policies.json | jq '.[].ManagedBookmarks[] | select(.name=="Lab") | .children[] | select(.name=="Online") | .children[].url' | wc -l`
sed -i "s/LABS/$LABS/g" README.md

# News resources
NEWS=`cat config/firefox/firefox-policies.json | jq '.[].ManagedBookmarks[] | select(.name=="News") | .children[].url' | wc -l`
sed -i "s/NEWS /$NEWS /g" README.md

# Blogs
#cat config/firefox/firefox-policies.json | jq '.[].ManagedBookmarks[] | select(.name=="Blogs") | .children[].url' | wc -l

# Recon
RECON=`cat config/firefox/firefox-policies.json | jq '.[].ManagedBookmarks[] | select(.name=="Recon") | .children[].url' | wc -l`
sed -i "s/RECON/$RECON/g" README.md

# Newsletters
NEWSLETTERS=`cat config/firefox/firefox-policies.json | jq '.[].ManagedBookmarks[] | select(.name=="Newsletters") | .children[].url' | wc -l`
sed -i "s/NEWSLETTERS/$NEWSLETTERS/g" README.md

# Web apps
WEB_APPS=`cat config/zsh/zshrc.zsh | grep "^PORT_" | wc -l`
sed -i "s/WEB_APPS/$WEB_APPS/g" README.md

# Firefox extensions
EXTENSIONS=`cat config/firefox/firefox-policies.json | jq '.[].ExtensionSettings[].install_url' | wc -l`
sed -i "s/EXTENSIONS/$EXTENSIONS/g" README.md

TELEGRAM=`cat config/firefox/firefox-policies.json | jq '.[].ManagedBookmarks[] | select(.name=="Misc") | .children[] | select(.name=="Telegram") | .children[].url' | wc -l`
sed -i "s/TELEGRAM/$TELEGRAM/g" README.md
