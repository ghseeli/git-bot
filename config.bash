#!/bin/bash

# User customizable vars
PULL_REQUEST_MODE=false
GOBBLE_SOURCE_FILE=false
UPSTREAM_REPO_OWNER="MareoRaft"
UPSTREAM_REPO_NAME="Integrable-Probability-Working-Seminar"
BOT_USERNAME_GIT="Axel Bot"
BOT_EMAIL_GIT="matthewmatics314@gmail.com"
# NEWFILEPATH="/root/Dropbox/[Spring 18] Integrable Probability Working Seminar/website.md"
NEWFILEPATH="/Users/Matthew/Dropbox (Personal)/[Spring 18] Integrable Probability Working Seminar/website.md"
RELFILEPATH="./README.md" # the file to be changed, relative to the repo

# Other vars
UPSTREAM_REPO_SSH_ADDRESS="git@github-as-axel-bot:$UPSTREAM_REPO_OWNER/$UPSTREAM_REPO_NAME.git"
LOCAL_REPO_NAME="axel-bot-$UPSTREAM_REPO_NAME"
LOCAL_REPO_PATH="$DIR/../$LOCAL_REPO_NAME"
