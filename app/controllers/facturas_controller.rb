class FacturasController < ApplicationController

  # Inicializa el index con los productos que tienen stock mayor a 5
  def index
    @productos = Producto.all.select { |p| p.stock > 5 }
    @tasas = Tasa.all
  end

  # Funcion de crear una nueva factura
  # Recibe un array de lineas con producto_id, cantidad y tasa_id
  # Crea una factura y sus detalles, ajustando el stock de los productos
  # Redirige a la vista de la factura creada o muestra un error si falla
  def create
    lineas = params[:lineas] || []

    ActiveRecord::Base.transaction do
      factura = Factura.create!(cliente: Cliente.first) 

      lineas.each do |linea|
        producto_id = linea[:producto_id]
        cantidad = linea[:cantidad].to_i
        tasa_id = linea[:tasa_id]

        next if cantidad <= 0 || producto_id.blank?

        producto = Producto.find(producto_id)
        tasa = Tasa.find_by(id: tasa_id)

        cantidad = [cantidad, producto.stock].min

        factura.detalle_facturas.create!(
          producto: producto,
          cantidad: cantidad,
          precio_unitario: producto.precio,
          tasa: tasa
        )

        producto.ajustar_stock!(cantidad: cantidad, tipo: 'salida', nota: "Venta mediante factura ##{factura.id}")
      end

      factura.calcular_totales
      factura.save!

      redirect_to factura_path(factura), notice: "Factura creada con éxito"
    end
  rescue => e
    redirect_to facturas_path, alert: "Error al crear la factura: #{e.message}"
  end

  # Muestra una factura específica por su ID
  def show
    @factura = Factura.find(params[:id])

    @factura.calcular_totales

    @lineas_con_totales = @factura.detalle_facturas.map do |detalle|
      subtotal = detalle.precio_unitario * detalle.cantidad
      impuesto = subtotal * ((detalle.tasa&.porcentaje || 0) / 100.0)
      total = subtotal + impuesto
      {
        detalle: detalle,
        subtotal: subtotal,
        impuesto: impuesto,
        total: total
      }
    end

    # Renderiza la factura en PDF
    respond_to do |format|
      format.html
      format.pdf do
        pdf = FacturaPdf.new(@factura, @lineas_con_totales)
        send_data pdf.render,
                  filename: "Factura_#{@factura.numero}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline' 
      end
    end
  end
end
