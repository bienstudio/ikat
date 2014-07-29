class BookmarkletFetchImages < IkatMutation
  required do
    string :url
  end

  def execute
    url = fix_url(self.url)

    doc = Nokogiri::HTML(open(url))

    images = doc.css('img')

    images.map { |img| img.to_s }

    images
  end

  def fix_url(str)
    str = str.insert(str.index(':') + 1, '/')
    str
  end
end
