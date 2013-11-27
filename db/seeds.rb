def create_payment_method(name)
  logo_url = "/assets/payment_methods/#{name.downcase.parameterize}-logo.png"
  PaymentMethod.find_or_create_by_name(:name => name, :logo_url => logo_url)
end

def create_tag_definition(name)
  TagDefinition.find_or_create_by_name(:name => name)
end

def create_area(name, latitude, longitude, radius)
  Area.find_or_create_by_name(:name => name, :latitude => latitude, :longitude => longitude, :radius => radius)
end

def create_user(first_name, last_name, email, avatar_url, work_area, provider, uid)
  User.find_or_create_by_email(
      :first_name => first_name,
      :last_name => last_name,
      :email => email,
      :avatar_url => avatar_url,
      :area => Area.find_by_name(work_area),
      :account_attributes => {
        :provider => provider,
        :uid => uid
      }
  )
end

# payment methods
create_payment_method '10Bis'
create_payment_method 'Cibus'
create_payment_method 'Credit Card'
create_payment_method 'Cash'

# tags
create_tag_definition('Homemade')
create_tag_definition('Italian')
create_tag_definition('Pizzeria')
create_tag_definition('American')
create_tag_definition('Hamburger')
create_tag_definition('Fast Food')
create_tag_definition('Asian')
create_tag_definition('Bistro')
create_tag_definition('Cafe')
create_tag_definition('Bar')
create_tag_definition('Grill')
create_tag_definition('Meat')
create_tag_definition('Seafood')
create_tag_definition('Middle Eastern')
create_tag_definition('Hummus')
create_tag_definition('Japanese')
create_tag_definition('Sushi')
create_tag_definition('Thai Food')
create_tag_definition('Dim Sum')
create_tag_definition('Mexican')
create_tag_definition('Salad')
create_tag_definition('Sandwich')
create_tag_definition('Conditure')
create_tag_definition('Ice Cream')
create_tag_definition('Indian')
create_tag_definition('Healthy')
create_tag_definition('Vegetarian')
create_tag_definition('Vegan')

# areas
create_area('Tel Aviv', 34.770738, 32.063501, 2)

# lunch
Lunch.create(:date => Date.today)