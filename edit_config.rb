#!/usr/bin/env ruby
require 'fileutils'
require 'optparse'
require 'nokogiri'

# Accepts a block that takes an Nokogiri XML doc as a parameter
# and modifies the XML doc as desired.
def apply_to_configs (root_directory, orig_file_extension, &block)
  config_files = Dir.glob("#{root_directory}/**/config.xml")
  config_files.each { |config|
    doc = Nokogiri::XML::Document.parse(File.read(config)) do |options|
      options.default_xml.noblanks # ignore initial whitespace
    end
    project = doc.at_xpath("//project")
    next if project.nil?
    FileUtils.cp config, "#{config}.#{orig_file_extension}"
    case block.arity
      when 1
        new_doc = yield doc
      when 2
        new_doc = yield doc, config
    end
    File.open("#{config}", 'w') {|f| doc.write_xml_to(f, :indent => 2) }
  }
end
