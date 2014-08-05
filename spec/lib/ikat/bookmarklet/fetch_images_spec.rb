require 'spec_helper'

describe BookmarkletFetchImages do
  let(:action) do
    VCR.use_cassette('spec/bookmarklet/fetch_images/action') do
      BookmarkletFetchImages.run(
        url: 'http%3A//shop.outlier.cc/shop/retail/ultrafine-merino-tee.html'
      )
    end
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Array }
end
