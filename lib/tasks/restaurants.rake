namespace :restaurants do

  desc 'Augment restaurants with tags'
  task :augment_tags, [] => :environment do
    add_tags(Restaurant.find(1), 'Hamburger', 'Fast Food')
    add_tags(Restaurant.find(2), 'Hamburger', 'American')
    add_tags(Restaurant.find(3), 'Homemade', 'Meat')
    add_tags(Restaurant.find(4), 'Sandwich')
    add_tags(Restaurant.find(5), 'Cafe')
    add_tags(Restaurant.find(6), 'Asian')
    add_tags(Restaurant.find(8), 'Pizzeria')
    add_tags(Restaurant.find(11), 'Salad')
    add_tags(Restaurant.find(12), 'Homemade', 'Fast Food', 'Middle Eastern')
    add_tags(Restaurant.find(14), 'Asian')
    add_tags(Restaurant.find(16), 'Meat')
    add_tags(Restaurant.find(21), 'Homemade')
    add_tags(Restaurant.find(22), 'Asian')
    add_tags(Restaurant.find(23), 'Homemade', 'Middle Eastern')
  end

  def add_tags(restaurant, *tags)
    tags.each do |tag|
      restaurant.tags.where(:quantity => 1, :tag_definition_id => TagDefinition.find_by_name(tag).id).first_or_create
    end
  end

end