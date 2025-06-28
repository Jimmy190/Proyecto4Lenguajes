class FacturasController < ApplicationController
  def create
    @factura = Factura.new(cliente_id: factura_params[:cliente_id])

    productos_params = params.dig(:factura, :productos) || {}

    ActiveRecord::Base.transaction do
      if @factura.save
        productos_params.each do |producto_id, detalle|
          next unless detalle[:seleccionado] == 'true'

          cantidad = detalle[:cantidad].to_i
          tasa_id = detalle[:tasa_id].presence
          producto = Producto.find(producto_id)

          @factura.detalle_facturas.create!(
            producto: producto,
            cantidad: cantidad,
            precio_unitario: producto.precio,
            tasa_id: tasa_id
          )
        end

        @factura.calcular_totales
        @factura.save!

        redirect_to @factura, notice: 'Factura creada correctamente.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Error al crear factura: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  private

  def factura_params
    params.require(:factura).permit(:cliente_id)
  end
end
