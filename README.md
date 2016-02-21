# Set of scripts used in/by Fedora SELinux packages 

## selinux/make-fedora-selinux-patch.sh

Creates/updates <package>-fedora.patch in package based on the latest fedora-selinux/selinux tree and <package>-$VERSION.tar.gz in
the current directory.

### Usage

    $ make-fedora-selinux-patch.sh <package>

With non-default values:

    $ VERSION=2.5-rc1 REPO=/home/bachradsusi/devel/github/bachradsusi/selinux.git  selinux/make-fedora-selinux-patch.sh libsepol

### Variables
* VERSION - release version
 * VERSION=2.5
* REPO    - a repository to create a patch from
 * REPO=https://github.com/fedora-selinux/selinux
* BRANCH  - a branch in the repository
 * BRANCH=master
