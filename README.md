# About this project

I use [Scrivener](https://www.literatureandlatte.com/scrivener/overview) to write books and other things.

Scrivener has terrible built-in version control. I like Git.

So I wanted an automated system for exporting a Scrivener project in plain text to git. This makes it easier to visualize (and back up) my changes over time.

# Software requirements

You need OSX, Scrivener, and Git for this project.

# Security requirements

You will need to authorize your terminal emulator program (I use iTerm) to have OSX accessibility access. This is true for any AppleScript program these days. You will get prompted to do this the first time you run the script. 

# Installation

Rename `settings.example` to `settings` and customize these two paths:

- `EXPORT_PATH` needs to be a scratch directory that exports can go in
- `REPO_PATH` needs to be an existing git repository that your project will get updated with.

# Usage

```
$ cd /path/to/scrivener-to-git
$ ./export
[Script output will follow]
```

# Limitations

- This is not set up to handle multiple Scrivener projects at a time. It will export whatever project is open in Scrivener to the git repo that you select.
- The "Draft" folder in Scrivener is what will get exported.
- This currently uses plain text only. No pictures or formatting will get preserved.
