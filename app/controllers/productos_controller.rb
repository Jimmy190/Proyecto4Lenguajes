class ProductosController < ApplicationController
  before_action :set_producto, only: %i[show edit update destroy]

  def index
    @productos = Producto.all
  end

  def show; end

  def new
    @producto = Producto.new
  end

  def edit; end

  def create
    @producto = Producto.new(producto_params)

    if @producto.save
      redirect_to @producto, notice: 'Producto creado correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @producto.update(producto_params)
      redirect_to @producto, notice: 'Producto actualizado correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @producto.destroy
    redirect_to productos_url, notice: 'Producto eliminado.'
  end

  private

  def set_producto
    @producto = Producto.find(params[:id])
  end

  def producto_params
    params.require(:producto).permit(:nombre, :precio, :stock)
  end
end
