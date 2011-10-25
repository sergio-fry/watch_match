FactoryGirl.define do
  factory :match do
    association :league
    team_1 { |match| match.association(:team) }
    team_2 { |match| match.association(:team) }
    team_1_odds 1.2
    team_2_odds 1.2
    goals_1 0
    goals_2 0
    half_goals_1 0
    half_goals_2 0
    draw_odds 1.2
    began_on { Time.mktime(2011, 10, 17) }
  end
end

