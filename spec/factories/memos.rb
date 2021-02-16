FactoryBot.define do
  factory :memo do
    content { "memo content" }
    address { "memo address" }
    created_at { 10.minutes.ago }
    association :user

    trait :yesterday do
      content { "yesterday content" }
      address { "yesterday address" }
      created_at { 1.day.ago }
    end

    trait :day_before_yesterday do
      content { "day_before_yesterday content" }
      address { "day_before_yesterday address" }
      created_at { 2.days.ago }
    end

    trait :now do
      content { "now content" }
      address { "now address" }
      created_at { Time.zone.now }
    end
  end
end
