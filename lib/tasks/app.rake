namespace :app do
  desc "Rebuild db with drop, create, migrate, test:prepare (dev and staging only)"
  task rebuild: :environment do
    input = ''
    STDOUT.puts "Drop, recreate, and migrate app database? y[es] or n[o]"
    input = STDIN.gets.chomp
    if input == "y" && (Rails.env.development? || Rails.env.staging?)
      Rake::Task["db:drop"].execute
      Rake::Task["db:create"].execute
      Rake::Task["db:migrate"].execute
      Rake::Task["db:test:prepare"].execute
    else
      puts "Aborting app:rebuild tasks"
    end
  end

  desc "Post-deployment and promotion processes"
  task release: :environment do
    Rake::Task["db:migrate"].execute
  end
end
