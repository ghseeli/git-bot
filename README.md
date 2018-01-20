# Axel Bot

This code powers @AxelBot 's internals, allowing it to create pull requests a repository of your choice, $WORKING_REPO.

## Directions/Usage

Assuming you already have the repository, and have installed everything, do the following:

  1. `cd` into the repository, usually named `axel-bot`
  2. `./axel-bot.sh`
  3. beep happily

## Installation/Requirements

This code is designed to work on a UNIX based system with git and the github CLI `hub`. Everything except hub can be set up by running `install.sh` if you have a copy of @AxelBot's private key.

## How it works

@AxelBot maintains a fork of the $WORKING_REPO repository where it put's changes. Then, it will create a pull request into $WORKING_REPO by running `axel-bot.sh`
