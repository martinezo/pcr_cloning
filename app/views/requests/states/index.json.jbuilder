json.array!(@requests_states) do |requests_state|
  json.extract! requests_state, :id, :name
  json.url requests_state_url(requests_state, format: :json)
end
