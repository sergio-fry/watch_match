FactoryGirl.define do
  factory :match do
    association :league
    team_1 { |match| match.association(:team) }
    team_2 { |match| match.association(:team) }
  end
end

