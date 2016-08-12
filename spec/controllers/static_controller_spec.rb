require "rails_helper"

describe StaticController, type: :controller do
  describe "#show" do
    render_views

    it "receives a success status for the show page" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it "renders the correct view template" do
      get :show
      expect(response).to render_template(:application)
    end
  end
end
