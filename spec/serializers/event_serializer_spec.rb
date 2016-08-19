require "rails_helper"

describe EventSerializer, type: :serializer do
  describe "serialization" do
    it "includes correct keys and values" do
      event = FactoryGirl.create(:event)
      serializer = described_class.new(event)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      serialized = JSON.parse(serialization.to_json)

      expect(serialized["data"]["id"]).to eql(event.id)
      expect(serialized["data"]["attributes"]["name"]).to eql(event.name)
      expect(serialized["data"]["attributes"]["description"]).to eql(event.description)
      expect(serialized["data"]["attributes"]["created-at"]).to eql(event.created_at.iso8601(3))
      expect(serialized["data"]["attributes"]["updated-at"]).to eql(event.updated_at.iso8601(3))
    end
  end
end
