module VehicleHelper
  def cents_to_dollars(cents)
    number_to_currency(cents / 100)
  end
end
