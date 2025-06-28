class MakeTasaIdNullableInDetalleFacturas < ActiveRecord::Migration[7.1]
  def change
    change_column_null :detalle_facturas, :tasa_id, true
  end
end
