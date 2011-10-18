namespace :h2h_stats do
  desc "load all leagues available"
  task :load_leagues => :environment do
    leagues_count = League.count
    H2hStatsCrawler.new.load_leagues
    print "Leagues added: #{League.count - leagues_count}\n"
  end

  desc "load new match for all visible leagues"
  task :load_new_matches => :environment do
    matches_count = Match.count
    League.where(:visible => true).each do |league|
      H2hStatsCrawler.new.load_new_matches(league)
    end
    print "Matches added: #{Match.count - matches_count}\n"
  end
end
