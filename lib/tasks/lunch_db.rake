namespace :lunch_db do

  desc 'Import restaurants from LunchDB'
  task :import, [] => :environment do
    response = HTTParty.get('http://lunchdb.herokuapp.com/restaurants?limit=5')
    response['restaurants'].each do |item|
      category = nil
      category = Category.find_or_create_by_name(item['cuisines'][0]['name']) if item['cuisines'].try(:[], 0).try(:[], 'name').present?
      puts "importing restuarant: #{item['name']}"
      Restaurant.find_or_create_by_name(
          :name => item['name'],
          :logo_url => "http:#{item['logo_url']}",
          :category => category,
          :location_attributes => {
              :street => street_name(item['address'], item['city']),
              :city => item['city'],
              :latitude => item['latitude'],
              :longitude => item['longitude']
          }
      )
    end
  end

  def street_name(street, city)
    street.gsub(city, '').gsub(',', '').gsub('.', '').strip
  end

end