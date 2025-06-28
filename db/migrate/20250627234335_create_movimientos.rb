class CreateMovimientos < ActiveRecord::Migration[7.1]
  def change
    create_table :movimientos do |t|
      t.references :producto, null: false, foreign_key: true
      t.integer :cantidad
      t.string :tipo
      t.string :nota

      t.timestamps
    end
  end
end
