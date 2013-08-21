json.array!(@searches) do |search|
  json.extract! search, :result
  json.url search_url(search, format: :json)
end
