class TasasController < ApplicationController
  before_action :set_tasa, only: %i[show edit update destroy]

  def index
    @tasas = Tasa.all
  end

  def show; end

  def new
    @tasa = Tasa.new
  end

  def edit; end

  def create
    @tasa = Tasa.new(tasa_params)

    if @tasa.save
      redirect_to @tasa, notice: 'Tasa creada correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tasa.update(tasa_params)
      redirect_to @tasa, notice: 'Tasa actualizada correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tasa.destroy
    redirect_to tasas_url, notice: 'Tasa eliminada.'
  end

  private

  def set_tasa
    @tasa = Tasa.find(params[:id])
  end

  def tasa_params
    params.require(:tasa).permit(:nombre, :porcentaje)
  end
end
