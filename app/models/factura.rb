class Factura < ApplicationRecord
  # Relación con las tablas de cliente y detalle_factura
  belongs_to :cliente
  has_many :detalle_facturas, dependent: :destroy

  # Validaciones para asegurar que los campos requeridos no estén vacíos
  validates :cliente, presence: true

  # Validaciones para asegurar que los campos numéricos tengan valores válidos
  before_create :asignar_numero
  before_save :calcular_totales

  # Callback para asignar un número único a la factura
  def asignar_numero
    self.numero = (Factura.maximum(:numero) || 0) + 1
  end

  # Método para calcular el total de impuestos de la factura
  def impuestos
    detalle_facturas.sum do |detalle|
      subtotal = detalle.precio_unitario * detalle.cantidad
      tasa = detalle.tasa&.porcentaje.to_f || 0
      subtotal * (tasa / 100.0)
    end
  end
  
  # Método para calcular el subtotal y total de la factura
  def calcular_totales
    self.subtotal = detalle_facturas.sum(&:subtotal)
    self.total = detalle_facturas.sum(&:total_con_impuesto)
  end
end
