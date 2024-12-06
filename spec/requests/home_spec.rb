require "rails_helper"

RSpec.describe "Homes" do
  describe "GET /index" do
    it "returns http success and render template index" do
      get "/home/index"
      expect(response).to have_http_status(:success).and render_template(:index)
    end
  end
end
