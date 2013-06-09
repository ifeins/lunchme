def create_payment_method(name)
  logo_url = "/assets/payment_methods/#{name.downcase.parameterize}-logo.png"
  PaymentMethod.find_or_create_by_name(:name => name, :logo_url => logo_url)
end

def create_category(name)
  Category.find_or_create_by_name(:name => name)
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