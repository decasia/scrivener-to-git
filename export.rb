#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'
require 'tmpdir'

# Utility output function
def ok(message)
  puts "✅ #{message}"
end

def die(message)
  puts "❌ #{message}"
  abort
end

settings_path = File.expand_path 'settings.yml', __dir__
applescript_path = File.expand_path 'scrivener-export.applescript', __dir__

# Load settings
settings = YAML.load_file settings_path

# Make temp directory
Dir.mktmpdir do |tmp_dir|
  ok "Using temp folder at #{tmp_dir}"

  # Run Scrivener export
  output = `osascript #{applescript_path} #{tmp_dir}`
  die("AppleScript output: #{output}") unless output.include?('/OK')
  die("AppleScript failed for some reason: #{output}") unless $?.success?

  # Find project name
  project_name = output.split('/').first.strip
  die("Failed to find project name in #{output}") if project_name.empty?
  ok "Successfully exported plain text from Scrivener project #{project_name}"

  # Find latest export folder
  latest_export_path = Dir.glob("#{tmp_dir}/*").first

  # Export folder should be a directory
  unless File.directory? latest_export_path
    puts "Contents of exported directory:", Dir.entries(tmp_dir)
    die("Latest export is not a directory")
  end

  # Look up repo path for this project
  repo_path = settings['repo_paths'][project_name]
  die("No repo path found for #{project_name}") unless repo_path

  # Verify that the repo has a content directory
  dest_path = "#{repo_path}/content"
  die("Repo #{repo_path} has no content directory") unless File.directory? dest_path

  # Remove original (easiest way to handle any removed files in the src folder)
  ok "Removing #{dest_path}"
  FileUtils.rm_rf "#{dest_path}"

  # Copy source to dest
  ok "Copying #{latest_export_path}/ to #{dest_path}"
  FileUtils.mv "#{latest_export_path}/", "#{dest_path}"

  ok "Successfully exported Scrivener project #{project_name} to git"
end