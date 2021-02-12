# メインのサンプルユーザーを1人作成する
user = User.create!(name:                  "Example User",
                    email:                 "example@user.org",
                    password:              "foobar",
                    password_confirmation: "foobar")

10.times do
  title = Faker::Lorem.sentence(word_count: 3)
  trip = user.trips.build(title: title)
  trip.save!
end
