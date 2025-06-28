class DetalleFacturasController < ApplicationController
  # Antes de ejecutar edit, update y destroy, se ejecuta set_detalle_factura para cargar el detalle correspondiente
  before_action :set_detalle_factura, only: %i[edit update destroy]

  # Acción para inicializar un nuevo detalle de factura para el formulario
  def new
    @detalle_factura = DetalleFactura.new
  end

  # Acción para crear un nuevo detalle de factura con los parámetros permitidos
  def create
    @detalle_factura = DetalleFactura.new(detalle_factura_params)

    if @detalle_factura.save
      # Si se guarda, redirige a la factura asociada
      redirect_to factura_path(@detalle_factura.factura), notice: 'Detalle agregado correctamente.'
    else
      # Si falla la validación, vuelve al formulario new con código 422
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  # Acción para actualizar un detalle existente con los parámetros permitidos
  def update
    # Intenta actualizar el detalle
    if @detalle_factura.update(detalle_factura_params)
      # Si se actualiza correctamente, redirige a la factura asociada con mensaje de éxito
      redirect_to factura_path(@detalle_factura.factura), notice: 'Detalle actualizado.'
    else
      # Si falla la validación, vuelve al formulario edit con código 422
      render :edit, status: :unprocessable_entity
    end
  end

  # Acción para eliminar un detalle de factura
  def destroy
    factura = @detalle_factura.factura
    @detalle_factura.destroy
    # Después de eliminar el detalle, redirige a la factura asociada con mensaje de confirmación
    redirect_to factura_path(factura), notice: 'Detalle eliminado.'
  end

  private

  # Método para buscar y asignar el detalle de factura basado en el id recibido en params
  def set_detalle_factura
    @detalle_factura = DetalleFactura.find(params[:id])
  end

  # Define los parámetros permitidos para crear o actualizar un detalle de factura (seguridad)
  def detalle_factura_params
    params.require(:detalle_factura).permit(:factura_id, :producto_id, :cantidad, :precio_unitario, :tasa_id)
  end
end
