#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/config.bash"

# Add ssh key source path to .gitignore
printf "$RSA_FILE_NAME\n" >> "$DIR/.gitignore"

# Setup GitBot's ssh key
if [ ! -f "$RSA_FILE_PATH" ]; then
	if [ -f "$RSA_SRC_FILE_PATH" ]; then
		# Setup GitBot's identity.
		cp "$RSA_SRC_FILE_PATH" "$RSA_FILE_PATH"
		chmod 600 "$RSA_FILE_PATH"
		if [ -e "$SSH_CONFIG_PATH" ]; then
			cp -n "$SSH_CONFIG_PATH" "$SSH_CONFIG_BACKUP_PATH"
		fi
		ssh-keygen -y -f "$RSA_FILE_PATH" > "$RSA_FILE_PATH".pub
		printf "Host github-as-$BOT_NAME\n    HostName github.com\n    User git\n    IdentityFile $RSA_FILE_PATH\n    IdentitiesOnly yes\n" >> "$SSH_CONFIG_PATH"
	else
		printf "Please make sure you get a copy of your GitBot's key and add it to this directory named as id_rsa.yourgitbotsname"
		exit 1
	fi
fi
if [ ! -d "$LOCAL_REPO_PATH" ]; then
	# Initialize GitBot's copy of the notes.
	# In THIS implementation, GitBot has a clone of the $UPSTREAM_REPO and commits directly to it, as opposed to RichardBot who had his own repo on his own account, and then made pull requests.
	git clone "$UPSTREAM_REPO_SSH_ADDRESS" "$LOCAL_REPO_PATH"
	cd "$LOCAL_REPO_PATH"
	git remote add "$BOT_NAME" "$UPSTREAM_REPO_SSH_ADDRESS"
	git pull "$BOT_NAME" master
	git config user.name "$BOT_USERNAME_GIT"
	git config user.email "$BOT_EMAIL_GIT"
fi

