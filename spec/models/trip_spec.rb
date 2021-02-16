RSpec.describe Trip, type: :model do
  let(:trip) { FactoryBot.create(:trip) }

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
end
