json.array!(@fees) do |fee|
  json.extract! fee, :id, :name, :amount
  json.url fee_url(fee, format: :json)
end
