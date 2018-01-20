DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NEWFILEPATH=$1
RELFILEPATH="./Axels Algebra II/axels-algebra-book-ii.tex" # the file to be changed, relative to the repo
WORKING_REPO="grad-school-notes"

# If user did not supply path, ask for one
if [ -z "$NEWFILEPATH" ]
	then
	read -p "Enter new file path: " NEWFILEPATH
fi

cd $DIR/../axel-bot-$WORKING_REPO

# Detect if there are unstaged changes.  If so, fail.  Otherwise, switch to master!
if [ ! -z "$(git diff --raw)" ]
	then
	printf "There are unstaged changes to axel-bot-$WORKING_REPO\!  There really shouldn't be ANY changes there\!  Axel's newest file should be inputted as a path.  Extra changes to notes should be made on the MAIN repository, not AxelBot's repository."
	return 1
fi
git checkout master

# Update AxelBot's $WORKING_REPO repo to newest version
git pull axel-bot master

# Add the file to AxelBot's $WORKING_REPO repo, and commit
mv "$NEWFILEPATH" "$RELFILEPATH"
git add "$RELFILEPATH"
git commit -m "Newest updates of Axel's notes"

# Push and make a pull request
git push axel-bot master
CURR_DATETIME=$(date +%Y%m%d%H%M%s)
git checkout -b pr/$CURR_DATETIME
git push -u axel-bot pr/$CURR_DATETIME
hub pull-request -b ghseeli/$WORKING_REPO:master -h AxelBot/$WORKING_REPO:pr/$CURR_DATETIME -m "Absofruitly."
git checkout master

printf "beep beep boop."
