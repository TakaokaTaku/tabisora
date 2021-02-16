RSpec.describe Trip, type: :model do
  let(:trip) { FactoryBot.create(:trip) }
  let!(:day_before_yesterday) { FactoryBot.create(:trip, :day_before_yesterday) }
  let!(:now) { FactoryBot.create(:trip, :now) }
  let!(:yesterday) { FactoryBot.create(:trip, :yesterday) }

  it "is valid" do
    expect(trip).to be_valid
  end

  it "is invalid with no title" do
    trip.title = "     "
    expect(trip).not_to be_valid
  end

  it "is invalid with the long title" do
    trip.title = "a" * 101
    expect(trip).not_to be_valid
  end

  it "is invalid with the long content" do
    trip.content = "a" * 201
    expect(trip).not_to be_valid
  end

  it "is sorted by latest" do
    expect(Trip.first).to eq now
  end
end
