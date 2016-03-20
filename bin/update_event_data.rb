#! /user/bin/env ruby
# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + "/../lib")

require 'grv-ranking'
require 'open-uri'
require 'rexml/document'

def main(env)
  logger = GrvRanking::Logger.get(env, "update_event_data.log")

  # XMLの取得
  url = 'http://groovecoaster.jp/xml/fmj2100/rank/event.xml'
  doc = nil
  open(url) do |f|
    doc = REXML::Document.new(f.read)
  end

  # データベース設定
  dbconf = File.dirname(__FILE__) + "/../config/database.yml"
  GrvRanking::Config.database(env, dbconf)

  # データベースに記録
  doc.elements.each('results/data') do |e|
    id              = e.attributes['id']
    title           = URI.unescape(e.elements['title'].text).gsub(/\+/, " ")
    open_date_time  = (e.elements['open_date'].text + " " + e.elements['open_time'].text)
    close_date_time = (e.elements['close_date'].text + " " + e.elements['close_time'].text)
    score_type      = e.elements['score_type'].text.to_i

    record = GrvRanking::Event.find_or_create_by(id: id)
    record.title           = title
    record.open_date_time  = Time.parse(open_date_time)
    record.close_date_time = Time.parse(close_date_time)
    record.score_type      = score_type
    record.save
  end
end

main(ARGV[0])
