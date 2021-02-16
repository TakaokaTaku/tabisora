RSpec.describe "TripsSearches", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:trip) { user.trips.create(title: "foo", address: "東京") }
  let!(:other_trip) { user.trips.create(title: "hoge", address: "大阪") }

  it "is searching trip interface" do
    login_as(user)
    visit root_path
    within ".trips" do
      expect(page).to have_content trip.title
      expect(page).to have_content other_trip.title
    end
    fill_in "title", with: trip.title
    click_on "検索"
    expect(page).to have_content trip.title
    expect(page).not_to have_content other_trip.title

    fill_in "title", with: other_trip.address
    click_on "検索"
    expect(page).to have_content other_trip.title
    expect(page).not_to have_content trip.title
  end
end
