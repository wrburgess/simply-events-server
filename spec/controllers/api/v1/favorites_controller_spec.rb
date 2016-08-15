require "rails_helper"

describe Api::V1::FavoritesController, type: :controller do
  describe "accepting requests" do
    context "unauthorized" do
      it "returns an unauthorized status code if the token is not present" do
        favorite = FactoryGirl.create :favorite
        get :show, params: { id: favorite.id }
        expect_status :forbidden
      end

      it "returns an unauthorized status code if the token is invalid" do
        token = Auth.issue(some_fake_key: 1)
        request.env["HTTP_AUTHORIZATION"] = "Bearer #{token}"
        favorite = FactoryGirl.create :favorite
        get :show, params: { id: favorite.id }
        expect_status :forbidden
      end

      it "returns an unauthorized status code if the user is not valid" do
        token = Auth.issue(user_id: 1)
        request.env["HTTP_AUTHORIZATION"] = "Bearer #{token}"
        favorite = FactoryGirl.create :favorite
        get :show, params: { id: favorite.id }
        expect_status :forbidden
      end

      it "returns an unauthorized status code if the token lacks the jwt protocol" do
        request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234").to_s
        favorite = FactoryGirl.create :favorite
        get :show, params: { id: favorite.id }
        expect_status :forbidden
      end
    end

    context "authorized" do
      let(:event) { FactoryGirl.create :event }
      let(:new_user) { FactoryGirl.create :user }
      let(:favorite) { FactoryGirl.create :favorite }
      let(:user) { FactoryGirl.create :user }

      before do
        authenticate_for_specs(user)
      end

      describe "#create" do
        it "creates and returns an favorite instance" do
          post  :create,
                params: {
                  event_id: event.id,
                  user_id: new_user.id
                }
          expect_json("data", attributes: { "event-id": event.id, "user-id": new_user.id })
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { "event-id": :string })
          expect_json_types("data", attributes: { "user-id": :string })
          expect_json_types("data", attributes: { "created-at": :date })
          expect_json_types("data", attributes: { "updated-at": :date })
          expect_status :created
        end

        it "creates a new instance" do
          expect do
            post  :create,
                  params: {
                    event_id: event.id,
                    user_id: new_user.id
                  }
          end.to change(Favorite, :count).by(1)
        end
      end

      describe "#show" do
        it "returns an favorite instance" do
          favorite.touch
          get :show, params: { id: favorite.id }
          expect_json("data", attributes: { "event-id": favorite.event.id, "user-id": favorite.user.id })
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { "event-id": :string })
          expect_json_types("data", attributes: { "user-id": :string })
          expect_json_types("data", attributes: { "created-at": :date })
          expect_json_types("data", attributes: { "updated-at": :date })
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of favorites" do
          FactoryGirl.create :favorite
          FactoryGirl.create :favorite
          get :index
          expect_json_sizes("data", 2)
          expect_status :ok
        end

        it "includes at least one of the instances" do
          favorite_2 = FactoryGirl.create :favorite
          get :index
          expect_json("data.?", attributes: { "event-id": favorite_2.event_id, "user-id": favorite_2.user_id })
        end
      end

      describe "#delete" do
        it "returns empty json" do
          favorite.touch
          delete :destroy, params: { id: favorite.id }
          expect_json_sizes 0
          expect_status :accepted
        end

        it "deletes the specified instance" do
          favorite.touch
          expect { delete :destroy, params: { id: favorite.id } }.to change(Favorite, :count).by(-1)
        end
      end
    end
  end
end
