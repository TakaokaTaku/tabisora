FactoryBot.define do
  factory :trip do
    title { "trip title" }
    created_at { 10.minutes.ago }
    association :user
  end
end
