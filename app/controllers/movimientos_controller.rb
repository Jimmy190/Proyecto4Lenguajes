class MovimientosController < ApplicationController
  before_action :set_movimiento, only: %i[show edit update destroy]

  def index
    @movimientos = Movimiento.includes(:producto).order(created_at: :desc)
  end

  def show; end

  def new
    @movimiento = Movimiento.new
  end

  def edit; end

  def create
    @movimiento = Movimiento.new(movimiento_params)

    if @movimiento.save
      redirect_to movimientos_path, notice: 'Movimiento registrado correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @movimiento.update(movimiento_params)
      redirect_to @movimiento, notice: 'Movimiento actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movimiento.destroy
    redirect_to movimientos_url, notice: 'Movimiento eliminado.'
  end

  private

  def set_movimiento
    @movimiento = Movimiento.find(params[:id])
  end

  def movimiento_params
    params.require(:movimiento).permit(:producto_id, :cantidad, :tipo, :nota)
  end
end
