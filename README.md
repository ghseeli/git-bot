# Git Bot

This code is a generalization to power bots like @RichardBot, allowing it to edit a repository.

## Installation/Requirements

1. Create a GitHub account for your bot.
2. Create a public/private key pair for your bot.
3. Clone the repo onto the computer where you want the bot to run.
4. Put the private key into the root of the repo (but don't commit it).
5. Install the GitHub CLI `hub`.
6. Run `install.bash`.

## Directions/Usage

Assuming you already have the repository, and have installed everything, do the following:

  1. `cd` into the cloned repository.
  2. Run `git-bot.bash` for a single run, or `python2.7 git_bot_watchdog.py` to have your bot run every time the file is changed.
  3. beep happily.


## How it works

For example, @RichardBot maintains a fork of the ghseeli/grad-school-notes repository where it put's changes. Then, it will create a pull request into ghseeli/grad-school-notes by running `richard-bot.sh`.
