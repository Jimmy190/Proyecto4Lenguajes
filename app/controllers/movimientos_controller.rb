class MovimientosController < ApplicationController
  before_action :set_producto, only: [:new, :create]

  # GET /movimientos
  def index
    @movimientos = Movimiento.includes(:producto).order(created_at: :desc)
  end

  # GET /movimientos/new
  # Inicializa un nuevo movimiento para un producto específico
  # Si no se especifica tipo, por defecto es 'entrada'
  # Si no se especifica producto_id, no se puede crear el movimiento
  def new
    @movimiento = Movimiento.new(
      producto: @producto,
      tipo: params[:tipo] || 'entrada'
    )
  end

  # POST /movimientos
  # Crea un nuevo movimiento para un producto específico
  # Asocia el movimiento al producto y ajusta su stock
  # Redirige a la lista de movimientos o muestra un error si falla
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

  # Método para buscar y asignar el producto basado en el id recibido en params
  def set_producto
    @producto = Producto.find(params[:producto_id]) if params[:producto_id]
  end

  # Define los parámetros permitidos para crear o actualizar un movimiento
  def movimiento_params
    params.require(:movimiento).permit(:producto_id, :cantidad, :tipo, :nota)
  end
end
