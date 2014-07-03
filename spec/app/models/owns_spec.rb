require 'spec_helper'

describe Owns do
  let(:owns) { create :owns }

  it { expect(owns).to be_valid }
end
