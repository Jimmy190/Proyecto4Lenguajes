# app/models/movimiento.rb
class Movimiento < ApplicationRecord
  # Relación con la tabla de productos
  belongs_to :producto, optional: true

  # Atributo virtual para almacenar el nombre del producto - Para guardar solo el nombre del producto no la referencia
  validates :cantidad, presence: true, numericality: { greater_than: 0 }
  validates :tipo, inclusion: { in: ['entrada', 'salida'] }

  # Antes de validar/guardar, guarda el nombre actual del producto
  before_validation :capturar_producto_nombre, on: :create

  private

  # Método para capturar el nombre del producto asociado
  def capturar_producto_nombre
    self.producto_nombre = producto&.nombre
  end
end
