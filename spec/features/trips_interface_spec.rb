RSpec.describe "Trips", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before { login_as(user) }

  context 'invalid trip' do
    it "fails creating trip" do
      visit root_path
      expect(page).to have_content "旅行ページがありません。\n新規作成して、写真を管理することができます。"
      within '.no-trips' do
        click_on "旅行を作成する"
      end
      expect(current_path).to eq new_trip_path
      click_on "旅行作成"
      expect(page).to have_selector ".alert-danger"
    end
  end

  context 'valid trip' do
    it "is success creating & destroying trip" do
      visit new_trip_path
      fill_in 'タイトル', with: 'valid'
      click_on "旅行作成"
      expect(page).to have_selector ".alert-success"
      within '.title' do
        expect(page).to have_content 'valid'
      end

      click_on "編集する"
      click_on "この旅行を削除"
      expect(current_path).to eq root_path
      expect(page).to have_selector ".alert-success"
    end
  end
end
