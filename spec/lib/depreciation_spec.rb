require "spec_helper"


describe Depreciation do
  let(:subject) { described_class.new(2014, false) }

  describe ".new" do
    it "returns an argument error if you provide the wrong data type for purchased" do
      expect { described_class.new(2014, "true") }.to raise_error(ArgumentError)
    end

    it "returns an argument error if you provide the wrong data type for the year" do
      expect { described_class.new("2014", true) }.to raise_error(ArgumentError)
    end
  end

  describe "#purchase_amount" do
    it "returns a non-zero value if purchase is true" do
      subject = described_class.new(2014, true)
      expect(subject.purchase_amount).to eq(Depreciation::RATES[:purchased])
    end

    it "returns zero if purchase is false" do
      expect(subject.purchase_amount).to eq(0)
    end
  end

  describe "#annual_amount" do
    it "reuturns zero if the year is in the future" do
      subject = described_class.new(2099, false)
      expect(subject.annual_amount).to eq(0)
    end

    it "calculates an annual amount" do
      expect(subject.annual_amount).to eq(750_000)
    end
  end

  describe "#total" do
    it "calculates a total depreciation amount" do
      subject = described_class.new(2014, true)
      total = subject.purchase_amount + subject.annual_amount
      expect(subject.total).to eq(total)
    end
  end
end
