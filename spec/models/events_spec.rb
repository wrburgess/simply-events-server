require "rails_helper"

describe Event, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:event)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:event, name: nil)).not_to be_valid
  end
end
