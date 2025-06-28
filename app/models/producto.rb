class Producto < ApplicationRecord
  # Relación con la tabla de movimientos
  has_many :movimientos, dependent: :nullify
  has_many :detalle_facturas, dependent: :nullify
  
  # Validaciones para asegurar que los campos requeridos no estén vacíos
  validates :nombre, presence: true
  validates :precio, numericality: { greater_than_or_equal_to: 0 }

  # Define un método para calcular el stock actual
  # Basado en los movimientos de entrada y salida
  def stock
    entradas = movimientos.where(tipo: 'entrada').sum(:cantidad)
    salidas = movimientos.where(tipo: 'salida').sum(:cantidad)
    entradas - salidas
  end

  # Método para verificar si el stock es bajo
  def stock_bajo?
    stock < 5
  end

  # Método para ajustar el stock, ya sea de entrada o salida
  def ajustar_stock!(cantidad:, tipo:, nota: nil)
    raise ArgumentError, "Cantidad debe ser entero positivo" unless cantidad.is_a?(Integer) && cantidad > 0
    raise ArgumentError, "Tipo debe ser 'entrada' o 'salida'" unless %w[entrada salida].include?(tipo)

    if tipo == 'salida' && stock < cantidad
      raise StandardError, "No hay suficiente stock para realizar esta salida"
    end

    movimientos.create!(cantidad: cantidad, tipo: tipo, nota: nota)
  end

# Método de clase para obtener productos con stock bajo
def self.con_stock_alto(minimo = 5)
    joins(:movimientos)
    .group('productos.id')
    .having(
      'COALESCE(SUM(CASE WHEN movimientos.tipo = ? THEN movimientos.cantidad ELSE 0 END), 0) - COALESCE(SUM(CASE WHEN movimientos.tipo = ? THEN movimientos.cantidad ELSE 0 END), 0) > ?',
      'entrada', 'salida', minimo
    )
  end
end
