class MovimientosController < ApplicationController
  before_action :set_producto, only: [:new, :create]

  # GET /movimientos
  def index
    @movimientos = Movimiento.includes(:producto).order(created_at: :desc)
  end

  def new
    @movimiento = Movimiento.new(
      producto: @producto,
      tipo: params[:tipo] || 'entrada'
    )
  end

  def create
    @movimiento = Movimiento.new(movimiento_params)
    @movimiento.producto = @producto

    if @movimiento.save
      redirect_to movimientos_path, notice: "Movimiento registrado exitosamente."
    else
      flash.now[:alert] = "No se pudo registrar el movimiento."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_producto
    @producto = Producto.find(params[:producto_id]) if params[:producto_id]
  end

  def movimiento_params
    params.require(:movimiento).permit(:producto_id, :cantidad, :tipo, :nota)
  end
end
