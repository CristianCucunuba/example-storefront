#!/usr/bin/env bash

# Please Use Google Shell Style: https://google.github.io/styleguide/shell.xml

# ---- Start unofficial bash strict mode boilerplate
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -o errexit  # always exit on error
set -o errtrace # trap errors in functions as well
set -o pipefail # don't ignore exit codes when piping output
set -o posix    # more strict failures in subshells
# set -x          # enable debugging

IFS=$'\n\t'
# ---- End unofficial bash strict mode boilerplate

cd "$(dirname "${BASH_SOURCE[0]}")/.."
uid=$(echo "${REACTION_USER:-1000:1000}" | cut -d : -f 1)
usermod --uid "${uid}" --non-unique node |& grep -v "no changes" || true
command=("./bin/start")
if [[ $# -gt 0 ]]; then
  command=($@)
fi
unset IFS
exec su-exec node ${command[*]}