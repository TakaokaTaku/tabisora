FactoryBot.define do
  factory :memo do
    content { "memo content" }
    address { "memo address" }
    created_at { 10.minutes.ago }
    association :user
  end
end
