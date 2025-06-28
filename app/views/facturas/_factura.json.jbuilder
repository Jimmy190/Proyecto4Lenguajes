json.extract! factura, :id, :cliente_id, :numero, :subtotal, :total, :created_at, :updated_at
json.url factura_url(factura, format: :json)
