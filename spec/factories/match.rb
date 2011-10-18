FactoryGirl.define do
  factory :match do
    association :league
    team_1 { |match| match.association(:team) }
    team_2 { |match| match.association(:team) }
    began_on { Time.mktime(2011, 10, 17) }
  end
end

