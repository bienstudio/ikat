require 'spec_helper'

describe BookmarkletFetchImagesWorker do
  before do
    VCR.insert_cassette('app/workers/bookmarklet_fetch_images_worker/action')
  end

  it 'adds a job' do
    expect {
      BookmarkletFetchImagesWorker.perform_async('needsupply.com/mens/outerwear/explorer-jacket.html')
    }.to change(BookmarkletFetchImagesWorker.jobs, :size).by 1
  end

  it 'sends a request to Faye'

  after do
    VCR.eject_cassette
  end
end
