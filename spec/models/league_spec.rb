require 'spec_helper'

describe League do
  before(:each) do
    @league = FactoryGirl.build(:league)
  end

  it "should have valid Factory" do
    @league.should be_valid
  end
end
