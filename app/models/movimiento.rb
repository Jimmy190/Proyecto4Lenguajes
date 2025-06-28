# app/models/movimiento.rb
class Movimiento < ApplicationRecord
  belongs_to :producto, optional: true

  validates :cantidad, presence: true, numericality: { greater_than: 0 }
  validates :tipo, inclusion: { in: ['entrada', 'salida'] }

  # Antes de validar/guardar, guarda el nombre actual del producto
  before_validation :capturar_producto_nombre, on: :create

  private

  def capturar_producto_nombre
    self.producto_nombre = producto&.nombre
  end
end
