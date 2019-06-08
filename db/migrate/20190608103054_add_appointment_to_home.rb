class AddAppointmentToHome < ActiveRecord::Migration[6.0]
  def change
    add_reference :homes, :appointment, null: false, foreign_key: true, index: true
  end
end
