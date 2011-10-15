require 'spec_helper'

describe Team do
  it "should have valid factory" do
    FactoryGirl.build(:team).should be_valid
  end
end
