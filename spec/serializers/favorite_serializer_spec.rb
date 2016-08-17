require "rails_helper"

describe FavoriteSerializer, type: :serializer  do
  describe "serialization" do
    subject { FactoryGirl.create(:favorite) }

    it "should include keys and values" do
      serializer = described_class.new(subject)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      serialized = JSON.parse(serialization.to_json)

      expect(serialized["data"]["id"]).to eql(subject.id)
      expect(serialized["data"]["attributes"]["user-id"]).to eql(subject.user_id)
      expect(serialized["data"]["attributes"]["event-id"]).to eql(subject.event_id)
      expect(serialized["data"]["attributes"]["created-at"]).to eql(subject.created_at.iso8601(3))
      expect(serialized["data"]["attributes"]["updated-at"]).to eql(subject.updated_at.iso8601(3))
    end
  end
end
