# About this project

I use [Scrivener](https://www.literatureandlatte.com/scrivener/overview) to write books and other things.

Scrivener has terrible built-in version control. I like Git.

So I wanted an automated system for exporting a Scrivener project in plain text to git. This makes it easier to visualize (and back up) my changes over time.

# Software requirements

You need OSX, Scrivener, Ruby, and Git for this project.

# Security requirements

You will need to authorize your terminal emulator program (I use iTerm) to have OSX accessibility access. This is true for any AppleScript program these days. You will get prompted to do this the first time you run the script. 

# Installation

1. Clone the repository into some path on your workstation.

2. Create two folders: 

- a scratch folder that export files can temporarily live in
- a new git repository for each project you plan on exporting. Each of these git repositories will need one subfolder called "content," which we will update with new content.

Rename `settings.yml.example` to `settings.yml` and add appropriate settings:

- `export_path` should point to the scratch folder.
- `repo_paths` should be a dictionary whose keys are Scrivener project names and whose values are paths to git repos.

# Usage

```
$ cd /path/to/scrivener-to-git
$ ruby export.rb
[Script output will follow]
```

You may then point your repository at some offsite provider (I like BitBucket), use git tools to visualize your project history, or whatever else you like using Git for.

# Limitations

- The "Draft" folder in Scrivener is what will get exported.
- This currently uses plain text only. No pictures or formatting will get preserved.
- The export only works in one direction. There is no way to update Scrivener with any changes you make in the Git repository. My theory is that Scrivener is the place where you do all your writing, and Git is just a mirror where version tracking can happen.
- Automatic removal of the export scratch folder is on hold while I verify that there are no strange edge cases. UI scripting is hard.
