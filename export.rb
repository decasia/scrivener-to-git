#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'
require 'tmpdir'

# Utility output function
def ok(message)
  puts "✅ #{message}"
end

# Load settings
settings = YAML.load_file 'settings.yml'

# Make temp directory
Dir.mktmpdir do |tmp_dir|
  ok "Using temp folder at #{tmp_dir}"

  # Run Scrivener export
  output = `osascript scrivener-export.applescript #{tmp_dir}`
  abort("AppleScript output: #{output}") unless output.strip.empty?
  abort("AppleScript failed for some reason: #{output}") unless $?.success?
  ok "Successfully exported plain text from Scrivener"

  # Find latest export folder
  latest_export_path = Dir.glob("#{tmp_dir}/*").first

  # Export folder should be a directory
  abort("Latest export is not a directory") unless File.directory? latest_export_path

  # Look up repo path for this project
  project_name = latest_export_path.split('|').last
  repo_path = settings['repo_paths'][project_name]
  abort("No repo path found for #{project_name}") unless repo_path

  # Verify that the repo has a content directory
  dest_path = "#{repo_path}/content"
  abort("Repo #{repo_path} has no content directory") unless File.directory? dest_path

  # Remove original (easiest way to handle any removed files in the src folder)
  ok "Removing #{dest_path}"
  FileUtils.rm_rf "#{dest_path}"

  # Copy source to dest
  ok "Copying #{latest_export_path}/ to #{dest_path}"
  FileUtils.mv "#{latest_export_path}/", "#{dest_path}"

  ok "Successfully exported Scrivener project #{project_name} to git"
end