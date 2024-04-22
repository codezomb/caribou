%i[lincoln toyota chevy dodge audi ford].each do |make|
  FactoryBot.create_list(:vehicle, 3, make)
end

Vehicle.limit(5).order("RANDOM()").each do |v|
  v.update(purchased_at: Time.now)
end
