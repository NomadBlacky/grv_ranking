#! /user/bin/env ruby
# coding: utf-8

class CreateEvents < ActiveRecord::Migration

  def change
    create_table :events do |t|
      t.text      :title
      t.timestamp :open_date_time
      t.timestamp :close_date_time
      t.integer   :score_type
    end
  end
  
end
