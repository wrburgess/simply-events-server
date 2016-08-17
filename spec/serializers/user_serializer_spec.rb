require "rails_helper"

describe UserSerializer, type: :serializer  do
  describe "serialization" do
    subject { FactoryGirl.create(:user) }

    it "should include keys and values" do
      serializer = described_class.new(subject)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      serialized = JSON.parse(serialization.to_json)

      expect(serialized["data"]["id"]).to eql(subject.id)
      expect(serialized["data"]["attributes"]["email"]).to eql(subject.email)
      expect(serialized["data"]["attributes"]["first-name"]).to eql(subject.first_name)
      expect(serialized["data"]["attributes"]["last-name"]).to eql(subject.last_name)
      expect(serialized["data"]["attributes"]["created-at"]).to eql(subject.created_at.iso8601(3))
      expect(serialized["data"]["attributes"]["updated-at"]).to eql(subject.updated_at.iso8601(3))
    end
  end
end
