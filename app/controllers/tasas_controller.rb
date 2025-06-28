class TasasController < ApplicationController
  before_action :set_tasa, only: %i[show edit update destroy]

  # GET /tasas
  # Muestra todas las tasas disponibles
  def index
    @tasas = Tasa.all
  end

  # GET /tasas/:id
  # Muestra una tasa específica por su ID
  def show; end

  # GET /tasas/new
  # Inicializa una nueva tasa para el formulario de creación
  def new
    @tasa = Tasa.new
  end

  # GET /tasas/:id/edit
  # Muestra el formulario de edición para una tasa existente
  def edit; end

  # POST /tasas
  # Crea una nueva tasa con los parámetros permitidos
  # Redirige a la vista de la tasa creada o muestra un error si falla
  def create
    @tasa = Tasa.new(tasa_params)

    if @tasa.save
      redirect_to @tasa, notice: 'Tasa creada correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasas/:id
  # Actualiza una tasa existente con los parámetros permitidos
  # Redirige a la vista de la tasa actualizada o muestra un error si falla
  def update
    if @tasa.update(tasa_params)
      redirect_to @tasa, notice: 'Tasa actualizada correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasas/:id
  # Elimina una tasa existente
  # Redirige a la lista de tasas con un mensaje de confirmación
  def destroy
    @tasa.destroy
    redirect_to tasas_url, notice: 'Tasa eliminada.'
  end

  private

  # Método para buscar y asignar la tasa basada en el id recibido en params
  def set_tasa
    @tasa = Tasa.find(params[:id])
  end

  # Define los parámetros permitidos para crear o actualizar una tasa (seguridad)
  def tasa_params
    params.require(:tasa).permit(:nombre, :porcentaje)
  end
end
