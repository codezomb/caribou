FactoryBot.define do
  factory :vehicle do
    model { Faker::Vehicle.unique.model(make_of_model: make) }
    msrp  { rand(30_000_00..120_000_00) }
    year  { Faker::Vehicle.year }

    trait :lincoln do
      make { "Lincoln" }
    end

    trait :toyota do
      make { "Toyota" }
    end

    trait :chevy do
      make { "Chevy" }
    end

    trait :dodge do
      make { "Dodge" }
    end

    trait :audi do
      make { "Audi" }
    end

    trait :ford do
      make { "Ford" }
    end
  end
end
