#!/bin/bash

# js
cd /data/ps-front
yarn
yarn run build

# ruby
cd /data

ruby <<-EOM
  CONFIG = JSON.parse("./config.json")
  Dir.mkdir(CONFIG["node_path"]) unless Dir.exist?(CONFIG["node_path"])
  Dir.mkdir(CONFIG["children_path"]) unless Dir.exist?(CONFIG["children_path"])
EOM

bundle config build.puma --with-cflags="-Wno-error=implicit-function-declaration"
bundle install

nohup bundle exec ruby ping_job.rb &

bundle exec ruby srv.rb
