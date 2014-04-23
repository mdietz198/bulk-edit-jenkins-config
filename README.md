bulk-edit-jenkins-config
========================

Ruby script for performing arbitrary edits to jenkins job configs in bulk

Getting started
---------------

 1. Run `bundle install`
 1. Copy example.rb with a file name describing the change the script will make
 1. Put your desired code into apply_to_configs
 1. Run the script as ./example.rb -l <path_to_jenkins_jobs_root>
