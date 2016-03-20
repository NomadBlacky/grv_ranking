#! /user/bin/env ruby
# coding: utf-8

require 'logger'
require 'fileutils'

p __FILE__
p File.dirname(__FILE__)

module GrvRanking

  module Logger
    class << self
      def get(env, file_name)
        dir = File.dirname(__FILE__) + "/../log/#{env}"
        FileUtils.mkdir_p(dir)
        ::Logger.new(dir + "/#{file_name}")
      end
    end
  end
  
end
