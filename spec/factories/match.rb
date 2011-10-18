FactoryGirl.define do
  factory :match do
    association :league
    team_1 { |match| match.association(:team) }
    team_2 { |match| match.association(:team) }
    team_1_odds 2.33
    team_2_odds 3.65
    goals_1 2
    goals_2 1
    half_goals_1 1
    half_goals_2 0
    draw_odds 2.20
    began_on { Time.mktime(2011, 10, 17) }
  end
end

