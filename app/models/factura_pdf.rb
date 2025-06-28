require 'prawn'
require 'prawn/table' 

class FacturaPdf < Prawn::Document

  # Constructor que recibe la factura y las líneas de detalle
  def initialize(factura, lineas)
    super(top_margin: 40)
    @factura = factura
    @lineas = lineas

    header
    lineas_table
    totals
  end

  # Métodos para generar el contenido del PDF
  def header
    text "Factura Nº #{@factura.numero}", size: 20, style: :bold
    move_down 20

    text "Cliente: #{@factura.cliente.nombre}"
    text "Correo: #{@factura.cliente.correo}"
    text "Dirección: #{@factura.cliente.direccion}"
    move_down 20
  end

  # Método para crear la tabla de líneas de detalle
  def lineas_table
    table(lineas_rows) do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ["F0F0F0", "FFFFFF"]
      self.column_widths = [120, 60, 80, 80, 80, 80]
    end
    move_down 20
  end
 
  # Método para construir las filas de la tabla de líneas
  def lineas_rows
    [["Producto", "Cantidad", "Precio Unitario", "Subtotal", "Impuesto", "Total"]] +
      @lineas.map do |linea|
        [
          linea[:detalle].producto.nombre,
          linea[:detalle].cantidad,
          price(linea[:detalle].precio_unitario),
          price(linea[:subtotal]),
          price(linea[:impuesto]),
          price(linea[:total])
        ]
      end
  end

  # Método para mostrar los totales de la factura
  # Muestra el subtotal general, total de impuestos y total final
  def totals
    text "Subtotal General: #{price(@factura.subtotal)}", size: 12, style: :bold
    text "Total Impuestos: #{price(@factura.impuestos)}", size: 12, style: :bold
    text "Total Final: #{price(@factura.total)}", size: 14, style: :bold
  end

  # Método auxiliar para formatear precios
  def price(num)
    "$#{'%.2f' % num}"
  end
end
