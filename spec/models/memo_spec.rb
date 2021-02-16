RSpec.describe Memo, type: :model do
  let(:memo) { FactoryBot.create(:memo) }

  it "is valid" do
    expect(memo).to be_valid
  end

  it "is valid with no content" do
    memo.content = "     "
    expect(memo).to be_valid
  end

  it "is valid with no address" do
    memo.address = "     "
    expect(memo).to be_valid
  end

  it "is invalid with no content and no address" do
    memo.content = "     "
    memo.address = "     "
    expect(memo).not_to be_valid
  end

  it "is invalid with the long content" do
    memo.content = "a" * 201
    expect(memo).not_to be_valid
  end
end
