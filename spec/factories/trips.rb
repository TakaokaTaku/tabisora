FactoryBot.define do
  factory :trip do
    title { "trip title" }
    created_at { 10.minutes.ago }
    association :user

    trait :yesterday do
      title { "yesterday" }
      created_at { 1.day.ago }
    end

    trait :day_before_yesterday do
      title { "day_before_yesterday" }
      created_at { 2.days.ago }
    end

    trait :now do
      title { "now!" }
      created_at { Time.zone.now }
    end
  end
end
