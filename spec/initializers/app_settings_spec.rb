require "rails_helper"

describe AppSettings, type: :class do
  it "will retrieve the app name" do
    expect(described_class.app_name).to eq("Simply Events Server")
  end

  it "will not retrieve the wrong app name" do
    expect(described_class.app_name).not_to eq("Simply Events")
  end
end
