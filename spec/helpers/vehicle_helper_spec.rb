require 'spec_helper'
include VehicleHelper

describe VehicleHelper do
  describe "#cents_to_dollars" do
    it "returns a dollar currency value from cents" do
      expect(cents_to_dollars(10_000_00)).to eq("$10,000.00")
    end
  end
end
