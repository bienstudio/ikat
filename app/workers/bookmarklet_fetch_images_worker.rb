class BookmarkletFetchImagesWorker
  include Sidekiq::Worker

  def perform(url)
    str = "BookmarkletFetchImagesWorker#perform: #{jid}"
    d { str }

    a = BookmarkletFetchImages.run(
      url: url,
      pusher_channel: "worker_#{jid}"
    )
  end
end
