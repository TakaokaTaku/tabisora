RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it "is invalid with no name" do
    user.name = "     "
    expect(user).not_to be_valid
  end

  it "is invalid with the long name" do
    user.name = "a" * 51
    expect(user).not_to be_valid
  end
end
