RSpec.feature "StaticPages", type: :feature do
  it "has correct links" do
    visit root_path
    expect(page).to have_link "旅空とは？", href: about_path
    expect(page).to have_link "ログイン",    href: new_user_session_path
    expect(page).to have_link "新規登録",    href: new_user_registration_path
    expect(page).to have_link "よくある質問", href: help_path
    expect(page).to have_link "利用規約",    href: terms_path
    expect(page).to have_link "お問合せ",    href: contact_path
  end
end
