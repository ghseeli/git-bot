#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# User customizable vars
WORKING_REPO="Integrable-Probability-Working-Seminar"
GIT_EMAIL="matthewmatics314@gmail.com"

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
if [ ! -d $DIR/../axel-bot-$WORKING_REPO ]; then
	# Initialize AxelBot's copy of the notes.
	mkdir $DIR/../axel-bot-$WORKING_REPO
	cd  $DIR/../axel-bot-$WORKING_REPO
	git init
	git remote add axel-bot git@github-as-axel-bot:AxelBot/$WORKING_REPO.git
	git pull axel-bot master
	git config user.name "Axel Bot"
	git config user.email $GIT_EMAIL
fi

