# frozen_string_literal: true

class CreateProprietors < ActiveRecord::Migration[6.0]
  def change
    create_table :proprietors do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
