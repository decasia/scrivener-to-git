# About this project

I use [Scrivener](https://www.literatureandlatte.com/scrivener/overview) to write books and other things.

Scrivener has terrible built-in version control. I like Git.

So I wanted an automated system for exporting a Scrivener project in plain text to git. This makes it easier to visualize (and back up) my changes over time.

# Software requirements

You need OSX, Scrivener, and Git for this project.

# Security requirements

You will need to authorize your terminal emulator program (I use iTerm) to have OSX accessibility access. This is true for any AppleScript program these days. You will get prompted to do this the first time you run the script. 

# Installation

1. Clone the repository into some path on your workstation.

2. Create two folders: 

- a scratch folder that export files can temporarily live in
- a new git repository to hold your book project. It also needs one subfolder called "content" which we will update with new content.

Rename `settings.example` to `settings` and customize these two paths:

- `EXPORT_PATH` should point to the scratch folder.
- `REPO_PATH` should point to your git repository.

# Usage

```
$ cd /path/to/scrivener-to-git
$ ./export
[Script output will follow]
```

You may then point your repository at some offsite provider (I like BitBucket), use git tools to visualize your project history, or whatever else you like using Git for.

# Limitations

- This is not set up to handle multiple Scrivener projects at a time. It will export whatever project is open in Scrivener to the git repo that you specify.
- The "Draft" folder in Scrivener is what will get exported.
- This currently uses plain text only. No pictures or formatting will get preserved.
- The export folder will need cleanup from time to time.
- The export only works in one direction. There is no way to update Scrivener with any changes you make in the Git repository. My theory is that Scrivener is the place where you do all your writing, and Git is just a mirror where version tracking can happen.
