class CreateDetalleFacturas < ActiveRecord::Migration[7.1]
  def change
    create_table :detalle_facturas do |t|
      t.references :factura, null: false, foreign_key: true
      t.references :producto, null: false, foreign_key: true
      t.integer :cantidad
      t.decimal :precio_unitario
      t.references :tasa, null: false, foreign_key: true

      t.timestamps
    end
  end
end
