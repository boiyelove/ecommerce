json.extract! product, :id, :title, :permalink, :summary, :price, :image, :description, :created_at, :updated_at
json.url product_url(product, format: :json)
