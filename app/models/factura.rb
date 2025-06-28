class Factura < ApplicationRecord
  belongs_to :cliente
  has_many :detalle_facturas, dependent: :destroy

  validates :cliente, presence: true

  before_create :asignar_numero
  before_save :calcular_totales

  def asignar_numero
    self.numero = (Factura.maximum(:numero) || 0) + 1
  end

  def calcular_totales
    self.subtotal = detalle_facturas.sum { |d| d.precio_unitario * d.cantidad }
    self.total = detalle_facturas.sum do |d|
      base = d.precio_unitario * d.cantidad
      tasa = d.tasa ? (d.tasa.porcentaje / 100.0) : 0
      base + (base * tasa)
    end
  end
end
