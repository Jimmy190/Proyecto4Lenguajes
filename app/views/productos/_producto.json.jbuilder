json.extract! producto, :id, :nombre, :precio, :stock, :created_at, :updated_at
json.url producto_url(producto, format: :json)
