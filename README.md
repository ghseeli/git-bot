# Axel Bot

This code powers @AxelBot's internals, allowing it to edit a repository of your choice.

## Directions/Usage

Assuming you already have the repository, and have installed everything, do the following:

  1. `cd` into the repository, usually named `axel-bot`
  2. Run `./axel-bot.sh` for a single run, or `python2.7 ./axel-bot-watchdog.py` to have axel-bot run every time the file is changed.
  3. beep happily

## Installation/Requirements

This code is designed to work on a UNIX based system with git and the github CLI `hub`. Everything except hub can be set up by running `install.sh` if you have a copy of @AxelBot's private key.

## How it works

@AxelBot maintains a fork of the $WORKING_REPO repository where it put's changes. Then, it will create a pull request into $WORKING_REPO by running `axel-bot.sh`
