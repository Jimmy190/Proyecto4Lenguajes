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
      # Si tiene stock inicial, crear movimiento de entrada
      if @producto.stock > 0
        @producto.ajustar_stock!(cantidad: @producto.stock, tipo: :entrada, nota: "Stock inicial")
      end
      redirect_to productos_path, notice: "Producto creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

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


  def destroy
    @producto.destroy
    redirect_to productos_path, notice: "Producto eliminado correctamente."
  end

  private

  def set_producto
    @producto = Producto.find(params[:id])
  end

  def producto_params
    params.require(:producto).permit(:nombre, :precio, :stock)
  end
end
