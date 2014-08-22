namespace :lunch_db do

  desc 'Import restaurants from LunchDB'
  task :import, [] => :environment do
    # currently fetching restaurants nearby the office
    latitude = 32.0631381
    longitude = 34.7706718
    radius = 3

    response = HTTParty.get("http://lunchdb.herokuapp.com/restaurants/?lat=#{latitude}&lng=#{longitude}&radius=#{radius}")
    response['restaurants'].each do |item|
      tags = [] # currently not taking the 10bis cuisines into consideration as they are not accurate
      item['cuisines'].each do |cuisine|
        hebrew_cuisine = cuisine.try(:[], 'name').presence
        if hebrew_cuisine.present?
          english_cuisine = CuisineMapper.map_cuisine hebrew_cuisine
          tag_definition = TagDefinition.find_by(name: english_cuisine) if english_cuisine.present?
          tag = {:tag_definition => tag_definition, :quantity => 1} if tag_definition.present?
          tags << tag if tag.present? and not tags.include? tag
        end
      end

      # only add restaurants that have an english name
      next if item['english_name'].blank?

      restaurant = Restaurant.find_or_create_by(name: item['english_name']) do |restaurant|
        restaurant.localized_name = item['name']
        restaurant.logo = fetch_logo(item['english_name'], item['logo_url']) if item['logo_url'].present?
        restaurant.payment_methods = [PaymentMethod.find_by(name: '10Bis')]
        restaurant.tags_attributes = tags
        restaurant.location_attributes = {
          street: street_name(item['address'], item['city']),
          city: item['city'],
          latitude: item['latitude'],
          longitude: item['longitude']
        }
      end

      # temporary update of logo
      if item['logo_url'].present?
        restaurant.update!(logo: fetch_logo(item['english_name'], item['logo_url']))
      end
    end
  end

  def street_name(street, city)
    street.gsub(city, '').gsub(',', '').gsub('.', '').strip
  end

  def fetch_logo(restaurant_name, logo_url)
    fixed_logo_url = logo_url.starts_with?('http') ? logo_url : "http:#{logo_url}"
    agent = Mechanize.new
    mechanize_file = agent.get(fixed_logo_url)
    filename = restaurant_name.downcase.gsub(/[ ']/, '-').gsub(/[()]/, '').gsub('.', '').gsub(/[\-]{2,}/,'-')
    extension = File.extname(mechanize_file.filename).downcase
    temp_filename = "#{Rails.root}/tmp/#{filename}#{extension}"

    mechanize_file.save temp_filename
    File.open(temp_filename)
  end

end