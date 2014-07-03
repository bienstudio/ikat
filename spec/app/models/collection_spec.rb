require 'spec_helper'

describe Collection do
  VCR.use_cassette('app/models/collection/collection', erb: { id: 'foobar' }) do
    let(:collection) { create :collection }
  end

  it { expect(collection).to be_valid }

  it { expect(collection).to validate_presence_of :name }
end
