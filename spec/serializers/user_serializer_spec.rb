require "rails_helper"

describe UserSerializer, type: :serializer do
  describe "serialization" do
    it "includes correct keys and values" do
      user = FactoryGirl.create(:user)
      serializer = described_class.new(user)
      serialization = ActiveModelSerializers::Adapter.create(serializer)
      serialized = JSON.parse(serialization.to_json)

      expect(serialized["data"]["id"]).to eql(user.id)
      expect(serialized["data"]["attributes"]["email"]).to eql(user.email)
      expect(serialized["data"]["attributes"]["first-name"]).to eql(user.first_name)
      expect(serialized["data"]["attributes"]["last-name"]).to eql(user.last_name)
      expect(serialized["data"]["attributes"]["created-at"]).to eql(user.created_at.iso8601(3))
      expect(serialized["data"]["attributes"]["updated-at"]).to eql(user.updated_at.iso8601(3))
    end
  end
end
