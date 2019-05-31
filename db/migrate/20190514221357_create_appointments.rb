# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :home, null: false, foreign_key: true
      t.references :tenant, null: false, foreign_key: true
      t.datetime 'starts_at'
      t.datetime 'ends_at'
      t.string 'kind'
      t.boolean 'weekly_recurring'

      t.timestamps
    end
  end
end
