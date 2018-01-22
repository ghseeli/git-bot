#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# USER CUSTOMIZABLE VARIABLES
# If true, the git-bot will be commiting to his own copy of the repo, and opening a pull request for his changes to be merged onto the main repo.  If false, the git-bot will commit directly to the main repo without human intervention.
PULL_REQUEST_MODE=false

# If true, the new input file to commit will be deleted from its source location.  If false, the input file will be left intact.
GOBBLE_SOURCE_FILE=true

# The GitHub username of the owner of the main repo
UPSTREAM_REPO_OWNER="ghseeli"

# The name of the main repo
UPSTREAM_REPO_NAME="grad-school-notes"

# The name of YOUR bot.  You should rename this from 'git-bot' to something else especially if you plan on having more than one GitBot.  This will be used in file names and shell scripts, so it is recommended to only use letters, numbers, dashes, and underscores.
BOT_NAME="richard-bot"

# The username of YOUR bot's GitHub account, which you must create manually.  You must change this accordingly.
BOT_USERNAME_GITHUB="RichardBot"

# git username, preferably the same as above
BOT_USERNAME_GIT="Richard Bot"

# git email address, preferably the same as the GitHub email address for your git-bot
BOT_EMAIL_GIT="ghseeli+richardbot@gmail.com"

# The path of the directory that contains the file that will be changed.  You can comment this out if you want the user to input the file path manually.
# NEWFILE_DIR_PATH="/Users/Matthew/Dropbox (Personal)/[Spring 18] Integrable Probability Working Seminar"

# The name of the file that will be changed (the source one).  You can comment this out if you want the user to input the file path manually.
# NEWFILE_NAME="website.md"

# The file to be changed (in the main repo), relative to the repo.
REPOFILE_PATH_REL="./README.md"


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
