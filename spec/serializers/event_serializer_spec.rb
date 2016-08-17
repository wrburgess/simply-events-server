require "rails_helper"

describe EventSerializer, type: :serializer  do
  describe "serialization" do
    subject { FactoryGirl.create(:event) }

    it "should include keys and values" do
      serializer = described_class.new(subject)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      serialized = JSON.parse(serialization.to_json)

      expect(serialized["data"]["id"]).to eql(subject.id)
      expect(serialized["data"]["attributes"]["name"]).to eql(subject.name)
      expect(serialized["data"]["attributes"]["description"]).to eql(subject.description)
      expect(serialized["data"]["attributes"]["created-at"]).to eql(subject.created_at.iso8601(3))
      expect(serialized["data"]["attributes"]["updated-at"]).to eql(subject.updated_at.iso8601(3))
    end
  end
end
