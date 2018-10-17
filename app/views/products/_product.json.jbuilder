json.extract! product, :id, :name, :description, :price, :supplier_id, :brand_id, :created_at, :updated_at
json.url product_url(product, format: :json)
