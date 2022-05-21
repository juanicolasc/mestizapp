json.extract! customer, :id, :name, :identification, :email, :created_at, :updated_at
json.url customer_url(customer, format: :json)
