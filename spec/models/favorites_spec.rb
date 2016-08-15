require "rails_helper"

describe Favorite, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:favorite)).to be_valid
  end

  it "is invalid without an event" do
    expect(FactoryGirl.build(:favorite, event_id: nil)).not_to be_valid
  end

  it "is invalid without a user" do
    expect(FactoryGirl.build(:favorite, user_id: nil)).not_to be_valid
  end

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :event }
end
