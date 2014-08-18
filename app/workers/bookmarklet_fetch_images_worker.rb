class BookmarkletFetchImagesWorker
  include Sidekiq::Worker

  def perform(url)
    a = BookmarkletFetchImages.run(
      url: url
    )

    # TODO: Should probably use Faye client instead of Net::HTTP
    message = { channel: "/workers", data: { images: a.result } }

    http = Net::HTTP.new("localhost", 5000)
    request = Net::HTTP::Post.new('/faye')
    request.set_form_data({ message: message.to_json })
    response = http.request(request)
  end
end
