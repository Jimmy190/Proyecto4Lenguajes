class Producto < ApplicationRecord
  has_many :movimientos
  has_many :detalle_facturas

  validates :nombre, presence: true
  validates :precio, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def stock_bajo?
    stock < 5
  end
end

