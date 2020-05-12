#!/bin/sh

AUTOPROJ_INSTALL_URL=https://raw.githubusercontent.com/rock-core/autoproj/master/bin/autoproj_install
BOOTSTRAP_URL=git@github.com:JotellyBarros/concept_build_conf.git

set -e

[ -f "autoproj_install" ] || wget -nv ${AUTOPROJ_INSTALL_URL}
[ -d ".autoproj" ] || { mkdir -p .autoproj; cat <<EOF > .autoproj/config.yml; }
---
osdeps_mode: all
GITORIOUS: ssh
GITHUB: ssh
EOF

export AUTOPROJ_OSDEPS_MODE=all
export AUTOPROJ_BOOTSTRAP_IGNORE_NONEMPTY_DIR=1

ruby autoproj_install
. ./env.sh
autoproj bootstrap git ${BOOTSTRAP_URL}
aup
amake
