#!/bin/bash

# Update settings
source $(dirname $0)/settings

# Run Scrivener export
osascript scrivener-export.applescript $EXPORT_PATH

# Copy to git
cd $EXPORT_PATH
LATEST_EXPORT=$(ls -t | head -1)

echo "Backing up $LATEST_EXPORT"

rsync -rzvu --ignore-times --delete "$LATEST_EXPORT"/ $REPO_PATH

cd $REPO_PATH

echo "Adding to git..."
git status
git add .

# git commit

# git push origin master
