RSpec.describe "TripsEdits", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:trip) { user.trips.create(title: "title") }

  before { login_as(user) }

  context 'invalid trip' do
    it "fails edit trip" do
      visit root_path
      within '.garally' do
        expect(page).to have_content 'title'
        click_on 'title'
      end
      expect(current_path).to eq trip_path(trip)
      within '.title' do
        expect(page).to have_content 'title'
      end
      click_on "編集する"
      fill_in 'タイトル', with: '  '
      click_on "変更する"
      expect(page).to have_selector ".alert-danger"
    end
  end

  context 'valid trip' do
    it "is success edit trip & destroying image" do
      visit trip_path(trip)
      within '.title' do
        expect(page).to have_content 'title'
      end
      within '.content' do
        expect(page).to have_content '「編集する」より、コメントを追加することができます。'
      end
      expect(page).to have_content '「編集する」より、写真を追加することができます。'
      expect(page).not_to have_selector ".detail-map"
      click_on "編集する"
      fill_in 'タイトル', with: 'valid title'
      fill_in 'コメント', with: 'valid comment'
      fill_in 'trip[address]', with: '東京'
      attach_file 'trip[images][]', "#{Rails.root}/spec/fixtures/test_image.jpg"
      click_on "変更する"
      expect(page).to have_selector ".alert-success"
      expect(page).to have_content 'valid title'
      within '.content' do
        expect(page).not_to have_content '「編集する」より、コメントを追加することができます。'
        expect(page).to have_content 'valid comment'
      end
      expect(page).not_to have_content '「編集する」より、写真を追加することができます。'
      expect(page).to have_selector ".detail-map"
      within '.trips' do
        expect(page).to have_selector "img[src$='test_image.jpg']"
      end

      click_on "写真を削除"
      within '.check-box' do
        check "trip[image_ids][]"
      end
      click_on "写真を削除"
      expect(page).to have_selector ".alert-success"
      expect(page).to have_content '「編集する」より、写真を追加することができます。'
    end
  end
end
