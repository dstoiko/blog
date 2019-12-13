#!/bin/sh

set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

hugo -t terminal

cd public

msg="update blog build on $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -am "$msg"

git push origin master
