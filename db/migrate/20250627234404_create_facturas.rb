class CreateFacturas < ActiveRecord::Migration[7.1]
  def change
    create_table :facturas do |t|
      t.references :cliente, null: false, foreign_key: true
      t.integer :numero
      t.decimal :subtotal
      t.decimal :total

      t.timestamps
    end
  end
end
