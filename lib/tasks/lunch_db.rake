namespace :lunch_db do

  desc 'Import restaurants from LunchDB'
  task :import, [] => :environment do
    response = HTTParty.get('http://lunchdb.herokuapp.com/restaurants?limit=100')
    response['restaurants'].each do |item|
      tags = []
      item['cuisines'].each do |cuisine|
        hebrew_cuisine = cuisine.try(:[], 'name').presence
        if hebrew_cuisine.present?
          english_cuisine = CuisineMapper.map_cuisine hebrew_cuisine
          tag_definition = TagDefinition.find_by_name english_cuisine if english_cuisine.present?
          tag = {:tag_definition => tag_definition, :quantity => 1} if tag_definition.present?
          tags << tag if tag.present?
        end
      end

      Restaurant.find_or_create_by_name(
          :name => item['name'],
          :logo_url => "http:#{item['logo_url']}",
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

end