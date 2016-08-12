require "rails_helper"

describe "checking basic stability of resources", type: :feature do
  describe "loading static pages" do
    it "visits the home page" do
      visit root_path
      expect(page.source).to have_css "body"
    end
  end
end
