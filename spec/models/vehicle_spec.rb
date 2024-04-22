require 'spec_helper'

describe Vehicle do
  let(:subject) { create(:vehicle, :dodge, purchased_at: Date.today) }

  describe "#valuation" do
    it "subtracts the depreciation from the msrp" do
      depreciation = Depreciation.new(subject.year, subject.purchased_at?)
      expect(subject.valuation).to eq(subject.msrp - depreciation.total)
    end
  end
end
