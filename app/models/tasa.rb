class Tasa < ApplicationRecord
# Relación con la tabla de detalle_factura
  has_many :detalle_facturas

  # Antes de ser destruida, desvincula las tasas de los detalles de factura
  before_destroy :desvincular_de_detalles

  # Validaciones para asegurar que los campos requeridos no estén vacíos
  validates :nombre, presence: true
  validates :porcentaje, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  # Método privado para desvincular las tasas de los detalles de factura
  def desvincular_de_detalles
    detalle_facturas.update_all(tasa_id: nil)
  end
end
