json.extract! order, :id, :date, :observations, :total_value, :tax, :tip, :guests, :active, :user_id, :customer_id, :table_id, :created_at, :updated_at
json.url order_url(order, format: :json)
