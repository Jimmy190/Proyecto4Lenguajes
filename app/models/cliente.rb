class Cliente < ApplicationRecord
  has_many :facturas

  validates :nombre, presence: true
  validates :correo, presence: true
  validates :direccion, presence: true
end
