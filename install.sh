#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# User customizable vars
UPSTREAM_REPO_OWNER="MareoRaft"
UPSTREAM_REPO_NAME="Integrable-Probability-Working-Seminar"
BOT_USERNAME_GIT="Axel Bot"
BOT_EMAIL_GIT="matthewmatics314@gmail.com"

# Other vars
UPSTREAM_REPO_SSH_ADDRESS="git@github-as-axel-bot:$UPSTREAM_REPO_OWNER/$UPSTREAM_REPO_NAME.git"
echo "$UPSTREAM_REPO_SSH_ADDRESS"
LOCAL_REPO_PATH="$DIR/../axel-bot-$UPSTREAM_REPO_NAME"

# Setup AxelBot's ssh key
if [ ! -f ~/.ssh/id_rsa.axel-bot ]; then
    if [ -f $DIR/id_rsa.axel-bot ]; then
	# Setup AxelBot's identity.
	cp $DIR/id_rsa.axel-bot ~/.ssh/id_rsa.axel-bot
	chmod 600 ~/.ssh/id_rsa.axel-bot
	if [ -e ~/.ssh/config ]; then
	    cp  ~/.ssh/config ~/.ssh/config.backup
	fi
	ssh-keygen -y -f ~/.ssh/id_rsa.axel-bot > ~/.ssh/id_rsa.axel-bot.pub
	cat $DIR/ssh-config >> ~/.ssh/config
    else
	printf "Please make sure you get a copy of AxelBot's key and add it to this directory named as id_rsa.axel-bot"
	exit 1
    fi
fi
if [ ! -d "$LOCAL_REPO_PATH" ]; then
	# Initialize AxelBot's copy of the notes.
	# In THIS implementation, AxelBot has a clone of the $UPSTREAM_REPO and commits directly to it, as opposed to RichardBot who had his own repo on his own account, and then made pull requests.
	git clone "$UPSTREAM_REPO_SSH_ADDRESS" "$LOCAL_REPO_PATH"
	cd "$LOCAL_REPO_PATH"
	git remote add axel-bot "$UPSTREAM_REPO_SSH_ADDRESS"
	git pull axel-bot master
	git config user.name "$BOT_USERNAME_GIT"
	git config user.email "$BOT_EMAIL_GIT"
fi

