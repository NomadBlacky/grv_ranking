#! /user/bin/env ruby
# coding: utf-8

class CreateEvents < ActiveRecord::Migration

  def change
    create_table :events do |t|
      t.text     :title
      t.datetime :open_date_time
      t.datetime :close_date_time
      t.integer  :score_type
    end
  end
  
end
