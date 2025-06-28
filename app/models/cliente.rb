class Cliente < ApplicationRecord
  # Relación con la tabla de facturas
  has_many :facturas

  # Validaciones para asegurar que los campos requeridos no estén vacíos
  validates :nombre, presence: true
  validates :correo, presence: true
  validates :direccion, presence: true
end
