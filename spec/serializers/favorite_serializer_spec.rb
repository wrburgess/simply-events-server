require "rails_helper"

describe FavoriteSerializer, type: :serializer do
  describe "serialization" do
    it "includes correct keys and values" do
      favorite = FactoryGirl.create(:favorite)
      serializer = described_class.new(favorite)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      serialized = JSON.parse(serialization.to_json)

      expect(serialized["data"]["id"]).to eql(favorite.id)
      expect(serialized["data"]["attributes"]["user-id"]).to eql(favorite.user_id)
      expect(serialized["data"]["attributes"]["event-id"]).to eql(favorite.event_id)
      expect(serialized["data"]["attributes"]["created-at"]).to eql(favorite.created_at.iso8601(3))
      expect(serialized["data"]["attributes"]["updated-at"]).to eql(favorite.updated_at.iso8601(3))
    end
  end
end
