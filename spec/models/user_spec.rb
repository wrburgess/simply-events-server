require "rails_helper"

describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
  end

  it "is invalid without a password" do
    expect(FactoryGirl.build(:user, password: nil)).not_to be_valid
  end

  it "is invalid without a password confirmation" do
    expect(FactoryGirl.build(:user, password_confirmation: nil)).not_to be_valid
  end

  it "is invalid without a password greater than 72 characters" do
    expect(FactoryGirl.build(:user, password: "7506fd42380020a0bc4e190fa55f8a8f49c276823ee604df4e46cc05efca8f35286b5304bca16a468e3fe2fd810a494141982b3ad333bb605cf69829e6802a1c")).not_to be_valid
  end

  it { is_expected.to have_many :favorites }
  it { is_expected.to have_many :favorite_events }
end
