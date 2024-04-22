class Vehicle < ApplicationRecord
  MINIMUM_PRICE = 30_000  # cannot be less than $300

  ##
  # Fetch the depreciations and calculate the valuation
  # if the valuation is below MINIMUM_PRICE return
  # MINIMUM_PRICE instead.
  def valuation
    depreciation = Depreciation.new(year, purchased_at?)
    [msrp - depreciation.total, MINIMUM_PRICE].max
  end
end
