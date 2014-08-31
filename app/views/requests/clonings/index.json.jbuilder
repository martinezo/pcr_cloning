json.array!(@requests_clonings) do |requests_cloning|
  json.extract! requests_cloning, :id, :name, :company, :mail, :phone, :shipping_address, :group_leader, :payment_method, :sample_name, :sample_volume, :pcr_product_size, :req_type, :sequencing_type, :inv_name, :inv_rfc, :inv_address, :inv_city, :inv_municipality, :inv_mail
  json.url requests_cloning_url(requests_cloning, format: :json)
end
