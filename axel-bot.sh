#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source config.bash

# If user did not supply path, ask for one
if [ -z "$NEWFILEPATH" ]; then
	read -p "Enter new file path: " NEWFILEPATH
fi

cd "$LOCAL_REPO_PATH"

# Detect if there are unstaged changes.  If so, fail.  Otherwise, switch to master!
if [ ! -z "$(git diff --raw)" ]; then
	printf "There are unstaged changes to $LOCAL_REPO_NAME\!  There really shouldn't be ANY changes there\!  Axel's newest file should be inputted as a path.  Extra changes to notes should be made on the MAIN repository, not AxelBot's repository."
	return 1
fi
git checkout master

# Update AxelBot's local repo to newest version of upstream repo.
git pull axel-bot master

# Add the file to AxelBot's local repo, and commit.
if [ "$GOBBLE_SOURCE_FILE" = true ]; then
	mv "$NEWFILEPATH" "$RELFILEPATH"
else
	cp "$NEWFILEPATH" "$RELFILEPATH"
fi
git add "$RELFILEPATH"
git commit -m "Newest update to $UPSTREAM_REPO_NAME."

# Push, and if pull-request mode is enabled, make a pull request.
git push axel-bot master
if [ "$PULL_REQUEST_MODE" = true ]; then
	printf "Creating pull request branch and pull request.\n"
	CURR_DATETIME=$(date +%Y%m%d%H%M%s)
	git checkout -b pr/$CURR_DATETIME
	git push -u axel-bot pr/$CURR_DATETIME
	hub pull-request -b $UPSTREAM_REPO_OWNER/$UPSTREAM_REPO:master -h AxelBot/$UPSTREAM_REPO:pr/$CURR_DATETIME -m "Absofruitly."
	git checkout master
fi

printf "beep beep boop."
