require 'spec_helper'

describe Wants do
  let(:wants) { create :wants }

  it { expect(wants).to be_valid }
end
