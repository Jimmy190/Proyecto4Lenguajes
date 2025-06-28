class AddProductoNombreToMovimientos < ActiveRecord::Migration[7.1]
  def change
    add_column :movimientos, :producto_nombre, :string
  end
end
