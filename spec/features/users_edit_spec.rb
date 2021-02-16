RSpec.describe "UsersEdits", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  it 'fails edit with wrong information' do
    login_as(user)

    click_on 'ユーザー編集'
    fill_in '名前', with: ' '
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in '新パスワード', with: '123'
    fill_in '新パスワード（確認用）', with: '456'
    click_on 'ユーザー情報を更新する'
    expect(current_path).to eq users_path
    within 'h1' do
      expect(page).to have_content "ユーザー編集"
    end
    expect(page).to have_selector ".alert-danger"
  end

  it "succeeds edit with correct information" do
    login_as(user)

    click_on 'ユーザー編集'
    fill_in '名前', with: 'Foo Bar'
    fill_in 'メールアドレス', with: 'foo@bar.com'
    fill_in '新パスワード', with: '123456'
    fill_in '新パスワード（確認用）', with: '123456'
    fill_in 'プロフィール変更にはパスワードが必要です', with: user.password
    click_on 'ユーザー情報を更新する'
    expect(current_path).to eq root_path
    expect(page).to have_selector ".alert-success"
  end
end
