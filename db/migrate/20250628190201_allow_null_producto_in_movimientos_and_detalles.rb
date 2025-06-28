class AllowNullProductoInMovimientosAndDetalles < ActiveRecord::Migration[7.1]
  def change
    change_column_null :detalle_facturas, :producto_id, true
  end
end
