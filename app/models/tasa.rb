class Tasa < ApplicationRecord
  has_many :detalle_facturas

  validates :nombre, presence: true
  validates :porcentaje, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
