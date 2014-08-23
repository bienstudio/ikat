class BookmarkletController < ApplicationController
  include ActionController::Live

  def show
    # Prevent Rails from blocking the display of a page on an external site.
    response.headers.delete('X-Frame-Options')

    # Just pass the Sidekiq job ID and the page URL to the view.
    @url = "http://#{params[:url]}" # FIXME: Actually do this correctly.
    @job_id = BookmarkletFetchImagesWorker.perform_async(params[:url])

    # Use Gon to give Pusher info.
    gon.pusher_channel = "worker_#{@job_id}"
    gon.pusher_key = ENV['PUSHER_KEY']

    render layout: false
  end
end
