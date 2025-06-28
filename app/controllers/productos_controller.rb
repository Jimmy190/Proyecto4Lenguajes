class ProductosController < ApplicationController
  before_action :set_producto, only: %i[show edit update destroy]

  # GET /productos
  # Muestra todos los productos disponibles
  def index
    @productos = Producto.all
  end

  # GET /productos/:id
  # Muestra un producto específico por su ID
  def show; end

  # GET /productos/new
  # Inicializa un nuevo producto para el formulario de creación
  def new
    @producto = Producto.new
  end

  # GET /productos/:id/edit
  # Muestra el formulario de edición para un producto existente
  def edit; end

  # POST /productos
  # Crea un nuevo producto con los parámetros permitidos
  # Redirige a la lista de productos o muestra un error si falla
  def create
    @producto = Producto.new(producto_params)

    if @producto.save
      # Si tiene stock inicial, crear movimiento de entrada
      if @producto.stock > 0
        @producto.ajustar_stock!(cantidad: @producto.stock, tipo: :entrada, nota: "Stock inicial")
      end
      redirect_to productos_path, notice: "Producto creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /productos/:id
  # Actualiza un producto existente con los parámetros permitidos
  # Ajusta el stock si ha habido cambios
  # Redirige a la lista de productos o muestra un error si falla
  def update
    old_stock = @producto.stock

    if @producto.update(producto_params)
      nuevo_stock = @producto.stock
      diferencia = (nuevo_stock - old_stock).abs

      if diferencia > 0
        tipo = nuevo_stock > old_stock ? :entrada : :salida

        if tipo == :salida && old_stock < diferencia
          flash.now[:alert] = "No hay suficiente stock para reducir."
          render :edit, status: :unprocessable_entity
          return
        end

        @producto.movimientos.create!(cantidad: diferencia, tipo: tipo.to_s, nota: "Ajuste de stock por edición")
      end

      redirect_to productos_path, notice: "Producto actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /productos/:id
  # Elimina un producto existente
  # Redirige a la lista de productos con un mensaje de confirmación
  def destroy
    @producto.destroy
    redirect_to productos_path, notice: "Producto eliminado correctamente."
  end

  private

  # Método para buscar y asignar el producto basado en el id recibido en params
  def set_producto
    @producto = Producto.find(params[:id])
  end
  # Define los parámetros permitidos para crear o actualizar un producto
  def producto_params
    params.require(:producto).permit(:nombre, :precio, :stock)
  end
end
