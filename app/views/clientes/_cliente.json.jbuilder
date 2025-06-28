json.extract! cliente, :id, :nombre, :correo, :direccion, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
