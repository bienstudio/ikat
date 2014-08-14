class BookmarkletController < ApplicationController
  include ActionController::Live

  def show
    # Prevent Rails from blocking the display of a page on an external site.
    response.headers.delete('X-Frame-Options')

    @job_id = BookmarkletFetchImagesWorker.perform_async(params[:url])

    render layout: false
  end

  def stream
    # response.headers['Content-Type'] = 'text/event-stream'

    # while Sidekiq::Status::working?(params[:job_id])
    #   response.stream.write({ job: :working })
    # end
    #
    # # should be set to either :complete or :failed now
    # if Sidekiq::Status::complete?(params[:job_id])
    #   response.stream.write({ job: :complete })
    # end

    # While working, continually check to see if it's done. Once it is, send
    #   the images through the stream and stop the loop.
    if Sidekiq::Status::complete?(params[:job_id])
      response.stream.write('id: 0\n')
      response.stream.write('event: complete\n')
      response.stream.write("data: #{JSON.dump(Sidekiq::Status::get(params[:job_id], :images))}")
    else
      response.stream.write("id: 0\n")
      response.stream.write("event: working\n")
      response.stream.write('data: working...')
    end

    100.times do
      response.stream.write "hello world\n"
      sleep 1
    end
  end
end
