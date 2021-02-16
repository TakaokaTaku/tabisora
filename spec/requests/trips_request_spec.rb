RSpec.describe "Trips", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:trip) { user.trips.create(title: "foo") }

  describe "Get" do
    describe "Home when log_in" do
      before { sign_in(user) }

      it "returns success request" do
        get root_path
        expect(response).to have_http_status(:success)
        expect(response.body).not_to include '旅空'
        expect(response.body).to include '旅行ページがありません。'
        assert_select "title", "TABISORA"
      end

      describe "searching for trips" do
        let!(:trip) { user.trips.create(title: "foo", address: "東京") }
        let!(:other_trip) { user.trips.create(title: "hoge", address: "大阪") }

        context "no-searching" do
          it "should display all trips" do
            get root_path
            expect(response.body).to include trip.title
            expect(response.body).to include other_trip.title
          end
        end

        context "searching [f]" do
          it "should display foo" do
            get root_path, params: {
              title: "f"
            }
            expect(response.body).to include trip.title
          end
        end

        context "searching [大阪]" do
          it "should display hoge" do
            get root_path, params: {
              title: "大",
            }
            expect(response.body).to include other_trip.title
          end
        end
      end
    end

    describe "/trips/:id" do
      let!(:other_user) { FactoryBot.create(:user) }
      let!(:other_trip) { other_user.trips.create(title: "foo") }

      it "redirects login when not logged in" do
        get trip_path(trip)
        expect(response).to redirect_to new_user_session_path
      end

      it "redirects home when not correct_user" do
        sign_in(user)
        get trip_path(other_trip)
        expect(response).to redirect_to root_path
      end
    end

    describe "/trips/new" do
      it "redirects login when not logged in" do
        get new_trip_path
        expect(response).to redirect_to new_user_session_path
      end

      it "returns success request" do
        sign_in(user)
        get new_trip_path
        expect(response).to have_http_status(:success)
        assert_select "title", "旅行作成 | TABISORA"
      end
    end
  end

  describe "POST /trips" do
    it "does not add new trips when not logged in" do
      expect do
        post trips_path, params: { trip: {
          title: "title"
        } }
      end.to change(Trip, :count).by(0)
      expect(response).to redirect_to new_user_session_path
    end

    it "adds new trips" do
      sign_in(user)
      expect do
        post trips_path, params: { trip: {
          title: "title"
        } }
      end.to change(Trip, :count).by(1)
    end
  end

  describe "PATCH /trip/:id" do
    let!(:other_user) { FactoryBot.create(:user) }
    let!(:other_trip) { other_user.trips.create(title: "foo") }

    it "fails edit when not logged in" do
      patch trip_path(trip)
      expect(response).to redirect_to new_user_session_path
    end

    it "fails edit when not correct_user" do
      sign_in(user)
      patch trip_path(other_trip), params: { trip: {
        title: " "
      } }
      expect(response).to redirect_to root_path
    end

    it 'fails edit with wrong information' do
      sign_in(user)
      patch trip_path(trip), params: { trip: {
        title: " "
      } }
      expect(trip.reload.title).to eq 'foo'
    end

    it 'succeeds edit with correct information' do
      sign_in(user)
      patch trip_path(trip), params: { trip: {
        title: "hoge"
      } }
      expect(trip.reload.title).to eq 'hoge'
    end
  end

  describe "Destroy /trip/:id" do
    let!(:other_user) { FactoryBot.create(:user) }
    let!(:other_trip) { other_user.trips.create(title: "foo") }

    it "fails when not logged in" do
      delete trip_path(trip)
      expect(response).to redirect_to new_user_session_path
    end

    it 'fails when not correct user' do
      sign_in(user)
      expect do
        delete trip_path(other_trip)
      end.to change(Trip, :count).by(0)
      expect(response).to redirect_to root_url
    end

    it 'succeds when correct user' do
      sign_in(user)
      trip = user.trips.create(title: "foo")
      expect do
        delete trip_path(trip)
      end.to change(Trip, :count).by(-1)
      expect(response).to redirect_to root_url
    end
  end
end
