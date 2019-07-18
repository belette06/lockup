# frozen_string_literal: true

class AddAppointmentsToHomes < ActiveRecord::Migration[6.0]
  def change
    add_reference :homes, :appointment, null: false, foreign_key: true
  end
end
