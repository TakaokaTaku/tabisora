# メインのサンプルユーザーを1人作成する
user = User.create!(name:                        "Example User",
                    email:                       "example@user.org",
                    password:                    "foobar",
                    password_confirmation:       "foobar")

other_user = User.create!(name:                  "Another User",
                          email:                 "another@user.org",
                          password:              "hogehoge",
                          password_confirmation: "hogehoge")

5.times do
  title = Faker::Lorem.sentence(word_count: 3)
  trip = user.trips.build(title: title)
  trip.save!
end

5.times do
  title   = Faker::Lorem.sentence(word_count: 3)
  content = Faker::Lorem.sentence(word_count: 5)
  address = Faker::Address.city

  trip = user.trips.build(title:   title,
                          content: content,
                          address: address)
  trip.save!
  10.times do
    trip.images.attach(io: File.open('db/sample/test_image.jpg'),
              filename: 'test_image.jpg', content_type: 'image/jpeg')
    trip.save!
  end
end

user.memos.create!(content: '東京観光に行きたい',
                   address: '東京')
user.memos.create!(content: '大阪観光に行きたい',
                   address: '大阪')
