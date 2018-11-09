#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

# Load settings
settings = YAML.load_file 'settings.yml'
export_path = settings['export_path']

# Run Scrivener export
output = `osascript scrivener-export.applescript #{export_path}`
abort("AppleScript output: #{output}") unless output.strip.empty?
abort("AppleScript failed for some reason: #{output}") unless $?.success?

# Find latest export folder
Dir.chdir export_path
latest_export = Dir['*'].sort_by { |f| File.mtime(f) }.last
latest_export_path = "#{export_path}/#{latest_export}"

# Export should be a directory
abort("Latest export is not a directory") unless File.directory? latest_export_path

# Look up repo path for this project
project_name = latest_export.split('|').last
repo_path = settings['repo_paths'][project_name]
abort("No repo path found for #{project_name}") unless repo_path

puts "rsync -rzvu --ignore-times --delete \"#{latest_export_path}/\" #{repo_path}/content"
puts `rsync -rzvu --ignore-times --delete \"#{latest_export_path}/\" #{repo_path}/content`
abort("Rsync failed.") unless $?.success?

# Remove temp folder
# puts "Removing #{export_path}/#{latest_export}"
# FileUtils.rm_rf("#{export_path}/#{latest_export}")

puts "Successfully exported Scrivener project #{project_name} to git."
