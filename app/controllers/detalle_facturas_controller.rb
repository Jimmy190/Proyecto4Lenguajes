class DetalleFacturasController < ApplicationController
  before_action :set_detalle_factura, only: %i[edit update destroy]

  def new
    @detalle_factura = DetalleFactura.new
  end

  def create
    @detalle_factura = DetalleFactura.new(detalle_factura_params)

    if @detalle_factura.save
      redirect_to factura_path(@detalle_factura.factura), notice: 'Detalle agregado correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @detalle_factura.update(detalle_factura_params)
      redirect_to factura_path(@detalle_factura.factura), notice: 'Detalle actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    factura = @detalle_factura.factura
    @detalle_factura.destroy
    redirect_to factura_path(factura), notice: 'Detalle eliminado.'
  end

  private

  def set_detalle_factura
    @detalle_factura = DetalleFactura.find(params[:id])
  end

  def detalle_factura_params
    params.require(:detalle_factura).permit(:factura_id, :producto_id, :cantidad, :precio_unitario, :tasa_id)
  end
end
