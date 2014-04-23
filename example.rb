#!/usr/bin/env ruby
require 'optparse'
require 'nokogiri'
require_relative './edit_config'

opts = OptionParser.new
opts.banner = "Usage: #{$0} -l LOCATION_JOBS_ROOT -o ORIGINAL_CONFIG_BACKUP_EXTENSION" 

opts.on("-l", "--location LOCATION_JOBS_ROOT", "specify path to root of the jenkins config directory") { |val|
  $local_jobs_root = File.absolute_path(val)
}

opts.on("-o", "--original FILE_EXTENSION", "save the config.xml to config.xml.<FILE_EXTENSION> before editing") { |val|
  $orig_file_extension = val
}

opts.on("-h", "-?", "--help", "Display this screen" ) do
  puts opts
  exit
end

args = opts.parse(ARGV)

$local_jobs_root = File.absolute_path(".") if $local_jobs_root == ""

$orig_file_extension = "orig" if $orig_file_extension.nil?

# config_doc is a Nokogiri::XML::Document
# your block will be passed all config.xml files found beneith the local_jobs_root directory 
apply_to_configs($local_jobs_root, $orig_file_extension) do |config_doc, config_path| 
  job_name = config_path.split("/")[-2]
  #Add code here to modify the XML document however you want
  node_you_want_to_modify = config_doc.at_xpath("//xpath_of_node_you_want_to_modify")
  node_you_want_to_modify.field_to_modify = new_value unless node_you_want_to_modify.nil?
  puts "Modified #{node_you_want_to_modify} for #{job_name}"
end
