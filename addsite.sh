#!/bin/bash

function heading  {
    echo $(tput bold)$(tput setaf 1)$@ $(tput sgr 0)
}

function prompt {
    echo $(tput bold)$(tput setaf 4)$@ $(tput sgr 0)
}

function slugify {
    echo "$1" | iconv -t ascii//TRANSLIT | sed -E s/[^a-zA-Z0-9]+/-/g | sed -E s/^-+\|-+$//g | tr A-Z a-z
}

# -------------------------------

echo
heading "Creating a new site."

echo
prompt "What is the title?"
read title

echo
echo What is the first author name?
read author

echo
echo What is the URL?
read url

echo
echo What is the open source repo URL, if there is one?
read repo

slug=`slugify "$title"`

# -------------------------------

buildpath="$PWD/source/_sites/$slug.md"
echo
echo "Creating a file at $buildpath"

touch $buildpath

date=`date +%Y-%m-%d`

cat <<EOT >> $buildpath
---
title: "$title"
authors: [$author]
url: $url
added: $date
repo: $repo
---
EOT

vim $buildpath
