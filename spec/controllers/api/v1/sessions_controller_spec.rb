require "rails_helper"

describe Api::V1::SessionsController, type: :controller do
  describe "accepting requests" do
    it "returns an unauthorized status code if the user is not authorized" do
      user = FactoryGirl.create :user
      get :create, params: { email: user.email, password: Faker::Internet.password }
      expect_status :forbidden
    end

    it "returns an unauthorized status code if the user does not exist" do
      get :create, params: { email: Faker::Internet.email, password: Faker::Internet.password }
      expect_status :forbidden
    end

    it "returns a token if the user is authorized" do
      password = Faker::Internet.password
      user = FactoryGirl.create :user, password: password, password_confirmation: password
      get :create, params: { email: user.email, password: password }
      expect_status :created
    end
  end
end
