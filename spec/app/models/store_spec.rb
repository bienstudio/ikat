require 'spec_helper'

describe Store do
  let(:store) do
    VCR.use_cassette('app/models/store/store', erb: { id: 'foobar' }) do
      create :store
    end
  end

  before do
    VCR.insert_cassette('app/models/store/all', erb: { id: 'foobar' })
  end

  it { expect(store).to be_valid }

  it { expect(store).to validate_presence_of :name }
  it { expect(store).to validate_presence_of :link }

  after do
    VCR.eject_cassette
  end
end
