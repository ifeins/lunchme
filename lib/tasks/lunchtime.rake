namespace :lunchtime do

  desc 'Create a new lunch for today if not already exist'
  task :create_lunch, [] => :environment do
    Lunch.create(date: Date.today) unless Lunch.where(date: Date.today).present?
  end

end