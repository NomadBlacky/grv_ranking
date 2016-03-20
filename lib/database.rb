#! /user/bin/env ruby
# coding: utf-8

require 'yaml'
require 'active_record'

module GrvRanking

  module Config
    class << self
      def database(env, config_file_path)
        config = YAML.load_file(config_file_path)
        ActiveRecord::Base.establish_connection(config[env])
        ActiveRecord::Base.default_timezone = :local
      end
    end
  end
  
end
