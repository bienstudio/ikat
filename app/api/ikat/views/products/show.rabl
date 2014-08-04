object @product

attributes :id, :name, :link, :price, :currency, :photo_url, :original_image

node :permalink do |p|
  p.permalink
end
