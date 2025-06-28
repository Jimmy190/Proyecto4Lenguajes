class ClientesController < ApplicationController
  # Antes de ejecutar show, edit, update y destroy, se ejecuta set_cliente para cargar el cliente
  before_action :set_cliente, only: %i[show edit update destroy]

  # Acción para listar todos los clientes
  def index
    @clientes = Cliente.all
  end

  # Acción para mostrar un cliente específico (usa @cliente seteado por set_cliente)
  def show; end

  # Acción para inicializar un nuevo cliente para el formulario de creación
  def new
    @cliente = Cliente.new
  end

  # Acción para mostrar el formulario de edición de un cliente existente (usa @cliente seteado)
  def edit; end

  # Acción para crear un nuevo cliente con los parámetros permitidos
  def create
    @cliente = Cliente.new(cliente_params)

    # Intenta guardar el cliente
    if @cliente.save
      # Si se guarda correctamente, redirige a la vista show del cliente con un mensaje de éxito
      redirect_to @cliente, notice: 'Cliente creado correctamente.'
    else
      # Si falla la validación, vuelve al formulario new con código de error 422
      render :new, status: :unprocessable_entity
    end
  end

  # Acción para actualizar un cliente existente con los parámetros permitidos
  def update
    # Intenta actualizar el cliente
    if @cliente.update(cliente_params)
      # Si se actualiza correctamente, redirige a la vista show con mensaje de éxito
      redirect_to @cliente, notice: 'Cliente actualizado correctamente.'
    else
      # Si falla la validación, vuelve al formulario edit con código 422
      render :edit, status: :unprocessable_entity
    end
  end

  # Acción para eliminar un cliente
  def destroy
    @cliente.destroy
    # Después de eliminar, redirige al listado de clientes con mensaje de confirmación
    redirect_to clientes_url, notice: 'Cliente eliminado.'
  end

  private

  # Método para buscar y asignar el cliente basado en el id recibido en params
  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  # Define los parámetros permitidos para crear o actualizar un cliente (seguridad)
  def cliente_params
    params.require(:cliente).permit(:nombre, :correo, :direccion)
  end
end
