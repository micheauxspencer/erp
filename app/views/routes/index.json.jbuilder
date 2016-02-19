json.array!(@routes) do |route|
  json.extract! route, :id, :name, :details, :status
  json.url route_url(route, format: :json)
end
