class CreateHomes < ActiveRecord::Migration[6.0]
  def change
    create_table :homes do |t|
      t.string :name
      t.references :proprietor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
