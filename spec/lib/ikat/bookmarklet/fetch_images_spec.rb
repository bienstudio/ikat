require 'spec_helper'

describe BookmarkletFetchImages do
  let(:action) do
    VCR.use_cassette('lib/bookmarklet/fetch_images/action') do
      BookmarkletFetchImages.run(
        url: 'needsupply.com/mens/outerwear/explorer-jacket.html',
        pusher_channel: nil
      )
    end
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Array }
end
