#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# User customizable vars
PULL_REQUEST_MODE=false
GOBBLE_SOURCE_FILE=false
UPSTREAM_REPO_OWNER="MareoRaft"
UPSTREAM_REPO_NAME="Integrable-Probability-Working-Seminar"
BOT_NAME="git-bot" # The name of YOUR bot.  You should rename this from 'git-bot' to something else especially if you plan on having more than one GitBot.  This will be used in file names and shell scripts, so it is recommended to only use letters, numbers, dashes, and underscores.
BOT_USERNAME_GITHUB="GitBot" # The username of YOUR bot's GitHub account, which you must create manually.  You must change this accordingly.
BOT_USERNAME_GIT="GitBot" # git username, preferably the same as above
BOT_EMAIL_GIT="matthewmatics314@gmail.com" # git email address, preferably the same as above
# NEWFILE_DIR_PATH="/root/Dropbox/[Spring 18] Integrable Probability Working Seminar"
NEWFILE_DIR_PATH="/Users/Matthew/Dropbox (Personal)/[Spring 18] Integrable Probability Working Seminar"
NEWFILE_NAME="website.md"
REPOFILE_PATH_REL="./README.md" # the file to be changed, relative to the repo


# Other vars
UPSTREAM_REPO_SSH_ADDRESS="git@github-as-$BOT_NAME:$UPSTREAM_REPO_OWNER/$UPSTREAM_REPO_NAME.git"
LOCAL_REPO_NAME="$BOT_NAME-$UPSTREAM_REPO_NAME"
LOCAL_REPO_PATH="$DIR/../$LOCAL_REPO_NAME"
NEWFILE_PATH="$NEWFILE_DIR_PATH/$NEWFILE_NAME"
REPOFILE_PATH="$LOCAL_REPO_PATH/$REPOFILE_PATH_REL" # Local repo
RSA_FILE_NAME="id_rsa.$BOT_NAME"
RSA_FILE_PATH="$HOME/.ssh/$RSA_FILE_PATH"
RSA_SRC_FILE_PATH="$DIR/$RSA_FILE_NAME"
SSH_CONFIG_PATH="$HOME/.ssh/config"
SSH_CONFIG_BACKUP_PATH="$SSH_CONFIG_PATH.backup"
