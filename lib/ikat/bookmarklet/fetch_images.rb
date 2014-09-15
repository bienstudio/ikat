class BookmarkletFetchImages < IkatMutation
  required do
    string :url
    string :pusher_channel, nils: true
  end

  def execute
    unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      str = "http://#{url}"
    end

    begin
      doc = Nokogiri::HTML(open(str))
    # handle if the server doesn't support redirecting http => https
    rescue RuntimeError => e
      # if it's a redirection error, try again
      if e.to_s.include?('redirection forbidden: http://')
        # add an 's' to make 'https' (BAD)
        str = str.insert(4, 's')

        # try again
        doc = Nokogiri::HTML(open(str))
      end
    end

    # get all the images
    images = doc.css('img')

    vetted_images = []
    images.each do |img|
      src = format_image_uri(img['src'], str)

      if check_image_dimensions(src)
        vetted_images << src

        unless pusher_channel.nil?
          # check to make sure that the client has loaded and subscribed to the channel

          occupied = false
          while occupied == false
            occupied = Pusher.channel(pusher_channel).info[:occupied]
          end

          Pusher.trigger(pusher_channel, 'event', { image: src })
        end
      end
    end

    return vetted_images
  end

  def format_image_uri(str, source_url)
    if str.include?('http') # it has a protocol, assume it has host (BAD)
      return str
    end

    # account for urls starting with //
    if str[0, 2] == '//'
      return "http:#{str}"
    end

    u = URI.parse(source_url)


    str = "#{u.scheme}://#{u.host}#{str}"

    return str
  end

  def check_image_dimensions(uri, width = 200, height = 200)
    dimensions = FastImage.size(uri)

    if dimensions
      dimensions[0] >= width && dimensions[1] >= height
    else
      false
    end
  end
end
