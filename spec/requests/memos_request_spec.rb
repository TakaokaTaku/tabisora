RSpec.describe "Memos", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:memo) { user.memos.create(content: "foo") }

  describe "Get /memos/new" do
    it "redirects login when not logged in" do
      get new_memo_path
      expect(response).to redirect_to new_user_session_path
    end

    it "returns success request" do
      sign_in(user)
      get new_memo_path
      expect(response).to have_http_status(:success)
      assert_select "title", "メモ | TABISORA"
    end
  end

  describe "POST /memos" do
    it "does not add new memos when not logged in" do
      expect do
        post memos_path, params: { memo: {
          content: "content"
        } }
      end.to change(Memo, :count).by(0)
      expect(response).to redirect_to new_user_session_path
    end

    it "adds new memos" do
      sign_in(user)
      expect do
        post memos_path, params: { memo: {
          content: "content"
        } }
      end.to change(Memo, :count).by(1)
      get new_memo_path
      expect(response.body).to include 'content'
    end
  end

  describe "Destroy /memo/:id" do
    let!(:other_user) { FactoryBot.create(:user) }
    let!(:other_memo) { other_user.memos.create(content: "foo") }

    it "fails when not logged in" do
      delete memo_path(memo)
      expect(response).to redirect_to new_user_session_path
    end

    it 'fails when not correct user' do
      sign_in(user)
      expect do
        delete memo_path(other_memo)
      end.to change(Memo, :count).by(0)
      expect(response).to redirect_to root_url
    end

    it 'succeds when correct user' do
      sign_in(user)
      memo = user.memos.create(content: "foo")
      expect do
        delete memo_path(memo)
      end.to change(Memo, :count).by(-1)
      expect(response).to redirect_to new_memo_path
    end
  end
end
