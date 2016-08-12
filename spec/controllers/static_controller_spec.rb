require "rails_helper"

describe StaticController, type: :controller do
  describe "#home" do
    render_views

    it "receives a success status for the home page" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end
end
