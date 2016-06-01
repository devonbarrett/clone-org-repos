#!/bin/bash
#
# -------------------------
# =    clone-org-repos    =
# -------------------------
#
# clone-org-repos allows you to clone all the repos for a github organisation
#
# This script is a useful way to backup an organisation's repos
#
# It's very hacked together, and will probably only work on Linux machines. If you
# run into any issues or have any comments/questions/concerns, please file an
# issue!
#
# Usage:
#   ./cloneOrgRepos.sh organisation_name
#

GITHUB_API='https://api.github.com'
HTTP_REGEX='s#.*\(https*://[^"]*\).*#\1#;p'
SEARCH_TERM='clone_url'

get_repos() {
  curl -s ${GITHUB_API}/orgs/$1/repos?per_page=200 | grep ${SEARCH_TERM} | sed -e ${HTTP_REGEX}
}

mkdir $1
cd $1

echo "Starting to clone github org: $1's repos"

while read repo; do
  git clone ${repo}
done < <(get_repos $1)

echo "Finished cloning repos into ./{$1}"
