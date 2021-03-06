#!/bin/sh

# This script pulls any new changes from Saltstack/salt.git to local repo
# And then pushes those changes to rallytime/salt.git.

for env_var in "${SALT_REPO}" "${ORIGIN}"; do
  if [[ -z "${env_var}" ]] ; then
      echo "Missing environment variable"
      exit 1;
  fi
done

cd ${SALT_REPO}

# Check if there are any unstaged changes
if [ -n "$(git status --porcelain)" ]; then
    git status
    echo "\nChanges present - Exiting.";
else
    # Update all relevant, constant branches
    for branch in 2017.7 2018.3 2019.2 develop
    do
        git checkout $branch
        git pull upstream $branch
        git push ${ORIGIN} $branch
    done
fi
