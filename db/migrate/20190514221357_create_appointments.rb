# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime 'starts_at'
      t.datetime 'ends_at'
      t.string 'kind', null: false
      t.boolean 'weekly_recurring'
      t.references :tenant, optional: true
      t.references :home
      t.timestamps
    end
  end
end
