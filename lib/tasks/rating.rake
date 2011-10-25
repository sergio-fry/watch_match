namespace :rating do
  desc "update rating for all matches"
  task :update => :environment do
    Match.all.each(&:save)
  end
end
