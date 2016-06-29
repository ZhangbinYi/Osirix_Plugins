#!/usr/bin/env ruby

# This program generates a new Osirix Plugin based off the files in PluginTemplate
# Copyright 2006 Shalev NessAiver

require 'find'

unless ARGV[0] and ARGV[1]
puts "Usage: ruby CreateNewPlugin.rb <plugin_name> <your_name>"
puts "This script will generate a new Osirix plugin with name plugin_name and files copyrighted as your_name."
Kernel.exit()
end

$plugin_name = ARGV[0]
$your_name = ARGV[1]
$cur_year = Time.now.year.to_s

`cp -R PluginTemplate ../../../#{$plugin_name}`

def replace_name(file)
  file.gsub(/PluginTemplate/, $plugin_name).gsub(/CURRENT_YEAR/, $cur_year).gsub(/YOUR_NAME/, $your_name)
end

Find.find(Dir.pwd + "/../../../#{$plugin_name}") do |path|
  fname = File.basename(path)
  puts "Modifying: #{path}"
  if FileTest.directory?(path)
    if fname[0] == ?.
      Find.prune       # Don't look any further into this directory.
      next
    end
	if fname == "OsiriXAPI.framework"
      Find.prune       # Don't look any further into this directory.
      next
    end
  else
    cur_file = replace_name(IO.read(path))
    File.open(path, "w") {|f| f.print cur_file}
  end
end

Find.find(Dir.pwd + "/../../..//#{$plugin_name}") do |path|
  if (fname = File.basename(path)) =~ /PluginTemplate/
    File.rename(path, File.dirname(path) + '/' + fname.sub(/PluginTemplate/, $plugin_name))
  end
end