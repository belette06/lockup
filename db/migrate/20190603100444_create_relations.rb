class CreateRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :relations do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :home, null: false, foreign_key: true

      t.timestamps
    end
  end
end