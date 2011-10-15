require 'spec_helper'

describe Match do
  it "should have valid factory" do
    FactoryGirl.build(:match).should be_valid
  end
end
