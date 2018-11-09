#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

# Load settings
settings = YAML.load_file 'settings.yml'
export_path = settings['export_path']

# Run Scrivener export
`osascript scrivener-export.applescript #{export_path}`
abort("AppleScript failed for some reason") unless $?.success?

# Find latest export folder
Dir.chdir export_path
latest_export = Dir['*'].sort_by { |f| File.mtime(f) }.last

# Look up repo path for this project
project_name = latest_export.split('|').last
repo_path = settings['repo_paths'][project_name]
abort("No repo path found for #{project_name}") unless repo_path

puts "rsync -rzvu --ignore-times --delete \"#{latest_export}/\" #{repo_path}/content"
`rsync -rzvu --ignore-times --delete \"#{latest_export}/\" #{repo_path}/content`
abort("Rsync failed.") unless $?.success?

# Remove temp folder
# FileUtils.rm_rf("#{export_path}/latest_export")
