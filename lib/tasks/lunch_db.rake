namespace :lunch_db do

  desc 'Import restaurants from LunchDB'
  task :import, [] => :environment do
    # currently fetching restaurants nearby the office
    latitude = 32.0631381
    longitude = 34.7706718
    radius = 3

    response = HTTParty.get("http://lunchdb.herokuapp.com/restaurants/?lat=#{latitude}&lng=#{longitude}&radius=#{radius}")
    response['restaurants'].each do |item|
      tags = []
      item['cuisines'].each do |cuisine|
        hebrew_cuisine = cuisine.try(:[], 'name').presence
        if hebrew_cuisine.present?
          english_cuisine = CuisineMapper.map_cuisine hebrew_cuisine
          tag_definition = TagDefinition.find_by_name english_cuisine if english_cuisine.present?
          tag = {:tag_definition => tag_definition, :quantity => 1} if tag_definition.present?
          tags << tag if tag.present? and not tags.include? tag
        end
      end

      # only add restaurants that have an english name
      next if item['english_name'].blank?

      Restaurant.find_or_create_by_name(
          :name => item['english_name'],
          :localized_name => item['name'],
          :logo => fetch_logo(item['logo_url']),
          :tags_attributes => tags,
          :location_attributes => {
              :street => street_name(item['address'], item['city']),
              :city => item['city'],
              :latitude => item['latitude'],
              :longitude => item['longitude']
          },
          :payment_methods => [
              PaymentMethod.find_by_name('10Bis'),
              PaymentMethod.find_by_name('Credit Card'),
              PaymentMethod.find_by_name('Cash')
          ]
      )
    end
  end

  def street_name(street, city)
    street.gsub(city, '').gsub(',', '').gsub('.', '').strip
  end

  def fetch_logo(logo_url)
    fixed_logo_url = logo_url.starts_with?('http') ? logo_url : "http:#{logo_url}"
    agent = Mechanize.new
    mechanize_file = agent.get(fixed_logo_url)
    filename = File.basename(mechanize_file.filename, File.extname(mechanize_file.filename))
    temp_filename = "#{Rails.root}/tmp/#{filename}"

    mechanize_file.save temp_filename
    File.open(temp_filename)
  end

end