#!/bin/bash

if [ $# -lt 1 ]; then
	cat <<EOF
Usage:
	\$ $0 <package>

Variables:
	VERSION	- release version
		- VERSION=2.7
	REPO	- a repository to create a patch from
		- REPO=https://github.com/fedora-selinux/selinux
	BRANCH	- a branch in the repository
		- BRANCH=master

Usage with changed variables:
	\$ VERSION=2.5-rc1 REPO=/home/bachradsusi/devel/github/bachradsusi/selinux.git  $0 libsepol

EOF
	exit 1
fi

PACKAGE=$1
PACKAGE_SUBDIR=${PACKAGE#selinux-}
VERSION=${VERSION:-2.7}
REPO=${REPO:-https://github.com/fedora-selinux/selinux}
BRANCH=${BRANCH:-master}

REBASEDIR=`mktemp -d rebase.XXXXXX`

pushd $REBASEDIR

git clone $REPO selinux

pushd selinux
git checkout $BRANCH
COMMIT=`git rev-parse --verify HEAD`
popd

# prepare $PACKAGE-fedora.patch
tar xfz ../$PACKAGE-$VERSION.tar.gz

pushd $PACKAGE-$VERSION
git init; git add .; git commit -m "init"
cp -r ../selinux/$PACKAGE_SUBDIR/* .
git add -A .
git diff --cached --src-prefix=$PACKAGE-$VERSION/ --dst-prefix=$PACKAGE-$VERSION/ > ../../$PACKAGE-fedora.patch
popd

popd
# echo rm -rf $REBASEDIR

echo $PACKAGE-fedora.patch created from $REPO/commit/$COMMIT
