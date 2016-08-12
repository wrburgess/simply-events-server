require "rails_helper"

describe Api::V1::EventsController, type: :controller do
  describe "accepting requests" do
    # context "unauthorized" do
    #   before do
    #     request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials("1234")
    #   end

    #   it "returns an unauthorized status code" do
    #     event = FactoryGirl.create :event
    #     get :show, id: event.id
    #     expect_status :forbidden
    #   end
    # end

    context "authorized" do
      let(:event) { FactoryGirl.create :event }

      describe "#create" do
        it "creates and returns an event instance" do
          post  :create,
                params: {
                  name: event.name,
                  description: event.description
                }
          expect_json("data", attributes: { name: event.name, description: event.description })
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { description: :string })
          expect_json_types("data", attributes: { "created-at": :date })
          expect_json_types("data", attributes: { "updated-at": :date })
          expect_status :created
        end

        it "creates a new instance" do
          event.touch
          expect do
            post  :create,
                  params: {
                    name: event.name,
                    description: event.description
                  }
          end.to change(Event, :count).by(1)
        end
      end

      describe "#show" do
        it "returns an event instance" do
          get :show, params: { id: event.id }
          expect_json("data", attributes: { name: event.name, description: event.description })
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { description: :string })
          expect_json_types("data", attributes: { "created-at": :date })
          expect_json_types("data", attributes: { "updated-at": :date })
        end

        it "returns a status of 200" do
          get :show, params: { id: event.id }
          expect_status :ok
        end
      end

      describe "#index" do
        it "returns a collection of events" do
          FactoryGirl.create :event
          FactoryGirl.create :event
          get :index
          expect_json_sizes("data", 2)
        end

        it "includes at least one of the instances" do
          event_2 = FactoryGirl.create :event
          get :index
          expect_json("data.?", attributes: { name: event_2.name, description: event_2.description })
        end

        it "returns a status of 200" do
          FactoryGirl.create :event
          FactoryGirl.create :event
          get :index
          expect_status :ok
        end
      end

      describe "#update" do
        it "updates the event" do
          put :update, params: { id: event.id, name: "New name" }
          expect_json("data", attributes: { name: "New name", description: event.description })
          expect_json_types("data", id: :string)
          expect_json_types("data", attributes: { name: :string })
          expect_json_types("data", attributes: { description: :string })
          expect_json_types("data", attributes: { "created-at": :date })
          expect_json_types("data", attributes: { "updated-at": :date })
        end

        it "returns a status of accepted (202)" do
          put :update, params: { id: event.id, name: "New name" }
          expect_status :accepted
        end
      end

      describe "#delete" do
        it "returns empty json" do
          delete :destroy, params: { id: event.id }
          expect_json_sizes 0
          expect_status :accepted
        end

        it "deletes the specified instance" do
          event.touch
          expect { delete :destroy, params: { id: event.id } }.to change(Event, :count).by(-1)
        end
      end
    end
  end
end
