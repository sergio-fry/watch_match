desc "This task is called by the Heroku cron add-on"
task :cron => "h2h_stats:load_new_matches" do
end
