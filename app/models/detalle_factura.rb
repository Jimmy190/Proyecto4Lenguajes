class DetalleFactura < ApplicationRecord
  belongs_to :factura
  belongs_to :producto
  belongs_to :tasa, optional: true

  validates :cantidad, presence: true, numericality: { greater_than: 0 }
  validates :precio_unitario, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_precio_unitario, on: :create

  def set_precio_unitario
    self.precio_unitario ||= producto.precio
  end

  def subtotal
    precio_unitario * cantidad
  end

  def monto_impuesto
    tasa ? subtotal * (tasa.porcentaje / 100.0) : 0
  end

  def total_con_impuesto
    subtotal + monto_impuesto
  end
end
