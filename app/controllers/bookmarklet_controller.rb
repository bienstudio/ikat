class BookmarkletController < ApplicationController
  include ActionController::Live

  def show
    # Prevent Rails from blocking the display of a page on an external site.
    response.headers.delete('X-Frame-Options')

    # Just pass the Sidekiq job ID and the page URL to the view.
    @url = "http://#{params[:url]}" # FIXME: Actually do this correctly.
    @job_id = BookmarkletFetchImagesWorker.perform_async(params[:url])

    render layout: false
  end
end
