require 'spec_helper'

describe Vehicle do
  let(:subject) { create(:vehicle, :dodge, purchased_at: Date.today) }

  describe "#valuation" do
    it "subtracts the depreciation from the msrp" do
      depreciation = Depreciation.new(subject.year, subject.purchased_at?)
      expect(subject.valuation).to eq(subject.msrp - depreciation.total)
    end

    it "should never have a valuation less than MINIMUM_PRICE" do
      depreciation = Depreciation.new(subject.year, subject.purchased_at?)
      subject.update!(msrp: depreciation.total) # make it calculate to 0

      expect(subject.valuation).to eq(described_class::MINIMUM_PRICE)
    end
  end
end
