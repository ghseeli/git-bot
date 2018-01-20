DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NEWFILEPATH=$1
RELFILEPATH="./Richards Algebra II/richards-algebra-book-ii.tex" # the file to be changed, relative to the repo
WORKING_REPO="grad-school-notes"

# If user did not supply path, ask for one
if [ -z "$NEWFILEPATH" ]
	then
	read -p "Enter new file path: " NEWFILEPATH
fi

cd $DIR/../richard-bot-$WORKING_REPO

# Detect if there are unstaged changes.  If so, fail.  Otherwise, switch to master!
if [ ! -z "$(git diff --raw)" ]
	then
	printf "There are unstaged changes to richard-bot-$WORKING_REPO\!  There really shouldn't be ANY changes there\!  Richard's newest file should be inputted as a path.  Extra changes to notes should be made on the MAIN repository, not RichardBot's repository."
	return 1
fi
git checkout master

# Update RichardBot's $WORKING_REPO repo to newest version
git pull richard-bot master

# Add the file to RichardBot's $WORKING_REPO repo, and commit
mv "$NEWFILEPATH" "$RELFILEPATH"
git add "$RELFILEPATH"
git commit -m "Newest updates of Richard's notes"

# Push and make a pull request
git push richard-bot master
CURR_DATETIME=$(date +%Y%m%d%H%M%s)
git checkout -b pr/$CURR_DATETIME
git push -u richard-bot pr/$CURR_DATETIME
hub pull-request -b ghseeli/$WORKING_REPO:master -h RichardBot/$WORKING_REPO:pr/$CURR_DATETIME -m "Absofruitly."
git checkout master

printf "beep beep boop."
