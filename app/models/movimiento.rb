class Movimiento < ApplicationRecord
  belongs_to :producto

  validates :cantidad, presence: true, numericality: { greater_than: 0 }
  validates :tipo, inclusion: { in: ['entrada', 'salida'] }

  after_create :actualizar_stock

  def actualizar_stock
    if tipo == 'entrada'
      producto.increment!(:stock, cantidad)
    elsif tipo == 'salida'
      producto.decrement!(:stock, cantidad)
    end
  end
end
