class AllowNullProductoIdOnMovimientos < ActiveRecord::Migration[7.1]
  def change
    change_column_null :movimientos, :producto_id, true
  end
end
