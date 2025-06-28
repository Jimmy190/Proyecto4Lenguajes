class Factura < ApplicationRecord
  belongs_to :cliente
  has_many :detalle_facturas, dependent: :destroy

  validates :cliente, presence: true

  before_create :asignar_numero
  before_save :calcular_totales

  def asignar_numero
    self.numero = (Factura.maximum(:numero) || 0) + 1
  end

  def impuestos
    detalle_facturas.sum do |detalle|
      subtotal = detalle.precio_unitario * detalle.cantidad
      tasa = detalle.tasa&.porcentaje.to_f || 0
      subtotal * (tasa / 100.0)
    end
  end
  
  def calcular_totales
    self.subtotal = detalle_facturas.sum(&:subtotal)
    self.total = detalle_facturas.sum(&:total_con_impuesto)
  end
end
