json.array!(@acedemic_years) do |acedemic_year|
  json.extract! acedemic_year, :id, :year, :start_date, :end_date
  json.url acedemic_year_url(acedemic_year, format: :json)
end
