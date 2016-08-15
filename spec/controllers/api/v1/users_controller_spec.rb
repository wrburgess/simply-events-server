require "rails_helper"

describe Api::V1::UsersController, type: :controller do
  describe "accepting requests" do
    context "unauthorized" do
      it "returns an unauthorized status code if the token is not present" do
        user = FactoryGirl.create :user
        get :show, params: { id: user.id }
        expect_status :forbidden
      end

      it "returns an unauthorized status code if the token is invalid" do
        token = Auth.issue(some_fake_key: 1)
        request.env["HTTP_AUTHORIZATION"] = "Bearer #{token}"
        user = FactoryGirl.create :user
        get :show, params: { id: user.id }
        expect_status :forbidden
      end

      it "returns an unauthorized status code if the user is not valid" do
        token = Auth.issue(user_id: 1)
        request.env["HTTP_AUTHORIZATION"] = "Bearer #{token}"
        user = FactoryGirl.create :user
        get :show, params: { id: user.id }
        expect_status :forbidden
      end

      it "returns an unauthorized status code if the token lacks the jwt protocol" do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234").to_s
        user = FactoryGirl.create :user
        get :show, params: { id: user.id }
        expect_status :forbidden
      end
    end

    context "authorized" do
      let(:user) { FactoryGirl.create :user }
      let(:new_user) { FactoryGirl.create :user }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns an user instance" do
          email = Faker::Internet.email
          password = Faker::Internet.password
          post  :create,
                params: {
                  email: email,
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  password: password,
                  password_confirmation: password
                }
          expect_json("data", attributes: { email: email })
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { email: :string })
          expect_json_types("data", attributes: { "first-name": :string })
          expect_json_types("data", attributes: { "last-name": :string })
          expect_json_types("data", attributes: { "created-at": :date })
          expect_json_types("data", attributes: { "updated-at": :date })
          expect_status :created
        end

        it "creates a new instance" do
          expect do
            email = Faker::Internet.email
            password = Faker::Internet.password
            post  :create,
                  params: {
                    email: email,
                    first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    password: password,
                    password_confirmation: password
                  }
          end.to change(User, :count).by(1)
        end
      end

      describe "#show" do
        it "returns an user instance" do
          get :show, params: { id: new_user.id }
          expect_json("data", attributes: { email: new_user.email })
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { email: :string })
          expect_json_types("data", attributes: { "first-name": :string })
          expect_json_types("data", attributes: { "last-name": :string })
          expect_json_types("data", attributes: { "created-at": :date })
          expect_json_types("data", attributes: { "updated-at": :date })
        end

        it "returns a status of 200" do
          get :show, params: { id: user.id }
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of users" do
          FactoryGirl.create :user
          FactoryGirl.create :user
          get :index
          expect_json_sizes("data", 3)
        end

        it "includes at least one of the instances" do
          user_2 = FactoryGirl.create :user
          get :index
          expect_json("data.?", attributes: { "first-name": user_2.first_name, "last-name": user_2.last_name })
        end

        it "returns a status of 200" do
          FactoryGirl.create :user
          FactoryGirl.create :user
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the user" do
          put :update, params: { id: new_user.id, first_name: "New name" }
          expect_json("data", attributes: { "first-name": "New name", "last-name": new_user.last_name })
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { email: :string })
          expect_json_types("data", attributes: { "first-name": :string })
          expect_json_types("data", attributes: { "last-name": :string })
          expect_json_types("data", attributes: { "created-at": :date })
          expect_json_types("data", attributes: { "updated-at": :date })
        end

        it "returns a status of accepted (202)" do
          put :update, params: { id: new_user.id, first_name: "New name" }
          expect_json("data", attributes: { "first-name": "New name", "last-name": new_user.last_name })
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, params: { id: new_user.id }
          expect_json_sizes 0
          expect_status :accepted
        end

        it "deletes the specified instance" do
          new_user.touch
          expect { delete :destroy, params: { id: new_user.id } }.to change(User, :count).by(-1)
        end
      end
    end
  end
end
