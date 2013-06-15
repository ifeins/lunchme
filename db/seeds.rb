def create_payment_method(name)
  logo_url = "/assets/payment_methods/#{name.downcase.parameterize}-logo.png"
  PaymentMethod.find_or_create_by_name(:name => name, :logo_url => logo_url)
end

def create_category(name)
  Category.find_or_create_by_name(:name => name)
end

def create_area(name, latitude, longitude, radius)
  Area.find_or_create_by_name(:name => name, :latitude => latitude, :longitude => longitude, :radius => radius)
end

def create_group(name, area)
  Group.find_or_create_by_name(:name => name, :area => area)
end

def create_user(first_name, last_name, email, avatar_url, provider, uid, group)
  User.find_or_create_by_email(
      :first_name => first_name,
      :last_name => last_name,
      :email => email,
      :avatar_url => avatar_url,
      :group => group,
      :account_attributes => {
        :provider => provider,
        :uid => uid
      }
  )
end

def create_lunch(group, date)
  Lunch.find_or_create_by_group_id_and_date(:group => group, :date => date)
end

# payment methods
create_payment_method '10Bis'
create_payment_method 'Cibus'
create_payment_method 'Credit Card'
create_payment_method 'Cash'

# categories
create_category('Homemade')
create_category('Italian')
create_category('American')
create_category('Asian')
create_category('Bistro')
create_category('Cafe')
create_category('Bar')
create_category('Grill')
create_category('Meat')
create_category('Seafood')
create_category('Middle Eastern')
create_category('Japanese')
create_category('Mexican')
create_category('Salad')
create_category('Sandwich')
create_category('Conditure')
create_category('Indian')

# areas
create_area('Tel Aviv', 34.770738, 32.063501, 2)

# groups
create_group('eBay IIC', Area.find_by_name('Tel Aviv'))

# users
create_user('Ticket', 'Oak',
            'ticketoak2000@gmail.com', 'https://graph.facebook.com/116090981872463/picture',
            'facebook', '116090981872463', Group.find_by_name('eBay IIC')
)

# lunches
lunch = create_lunch(Group.find_by_name('eBay IIC'), '2013-06-15')

# votes
lunch.votes.create(:user => User.find_by_email('ticketoak2000@gmail.com'), :restaurant => Restaurant.find(10))
