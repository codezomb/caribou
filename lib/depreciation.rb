class Depreciation
  RATES = {
    # The amount to deduct if the vehicle has been purchased
    purchased: 200_000,

    # The amounts to deduct based on age of the vehicle
    # Ages are treated as a range, if no next age
    # then it will apply all remaining years
    annual: [
      { age: 0, amount: 100_000 },
      { age: 5, amount: 50_000  }
    ].sort do |a,b|
      b[:age] <=> a[:age]
    end
  }

  ##
  # @param [Integer] the year the vehicle was manufactured
  # @param [Boolean] whether the vehicle was purchased
  def initialize(year, purchased)
    type_error("purchased", "Boolean") unless !!purchased == purchased
    type_error("year", "Integer") unless year.is_a?(Integer)

    @purchased = purchased
    @year      = year
  end

  ##
  # This method calculates the annual depreciation based
  # on the configured rates above. The rates are sorted
  # and processed in descending order by age in order
  # to allow for expanding the rates.
  def annual_amount
    calculated_age = Date.today.year - @year

    RATES[:annual].sum do |rate|
      next 0 if rate[:age] > calculated_age
      years = calculated_age - rate[:age]
      calculated_age = rate[:age]

      years * rate[:amount]
    end
  end

  ##
  # This method returns the purchase depreciation value
  # if the vehicle has been purchased
  def purchase_amount
    @purchased ? RATES[:purchased] : 0
  end

  ##
  # This method sums up all of the other values and
  # returns that value as the total.
  def total
    [
      purchase_amount,
      annual_amount
    ].sum
  end

  private

  def type_error(name, type)
    str = "#{name} parameter should be a #{type}"
    raise ArgumentError.new(str)
  end
end
