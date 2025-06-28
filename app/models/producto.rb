class Producto < ApplicationRecord
  has_many :movimientos, dependent: :nullify

  validates :nombre, presence: true
  validates :precio, numericality: { greater_than_or_equal_to: 0 }

  # Calcula el stock actual sumando entradas y restando salidas
  def stock
    entradas = movimientos.where(tipo: 'entrada').sum(:cantidad)
    salidas = movimientos.where(tipo: 'salida').sum(:cantidad)
    entradas - salidas
  end

  def stock_bajo?
    stock < 5
  end

  # Método para ajustar stock creando movimientos
  def ajustar_stock!(cantidad:, tipo:, nota: nil)
    raise ArgumentError, "Cantidad debe ser entero positivo" unless cantidad.is_a?(Integer) && cantidad > 0
    raise ArgumentError, "Tipo debe ser 'entrada' o 'salida'" unless %w[entrada salida].include?(tipo)

    if tipo == 'salida' && stock < cantidad
      raise StandardError, "No hay suficiente stock para realizar esta salida"
    end

    movimientos.create!(cantidad: cantidad, tipo: tipo, nota: nota)
  end
end
