RSpec.describe "Tests", type: :request do
  describe "GET /" do
    it "is displayed Hello, world!" do
      get root_path
      expect(response.body).to include "Hello, world!"
    end
  end
end
