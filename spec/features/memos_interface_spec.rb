RSpec.describe "Memos", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before { login_as(user) }

  context 'invalid memo' do
    it "fails creating memo" do
      visit new_memo_path
      expect(page).to have_content "行きたい場所のメモを追加しよう"
      within '.form-open' do
        click_on "メモを追加"
      end
      within '.form-box' do
        click_on "メモを追加"
      end
      expect(page).to have_selector ".alert-danger"
    end
  end

  context 'valid memo' do
    it "is success creating & destroying memo" do
      visit new_memo_path
      within '.form-open' do
        click_on "メモを追加"
      end
      within '.form-box' do
        fill_in 'memo[address]', with: '東京'
        fill_in '内容', with: 'vaild'
        click_on "メモを追加"
      end
      expect(page).to have_selector ".alert-success"
      within '.memos' do
        expect(page).to have_content '東京'
        expect(page).to have_content 'vaild'
      end

      click_on "削除"
      expect(page).to have_selector ".alert-success"
      expect(page).not_to have_selector ".memos"
    end
  end
end
