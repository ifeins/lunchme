def create_payment_method(name)
  logo_url = "/assets/payment_methods/#{name.downcase.parameterize}-logo.png"
  PaymentMethod.find_or_create_by_name(:name => name, :logo_url => logo_url)
end

create_payment_method '10Bis'
create_payment_method 'Cibus'
create_payment_method 'Credit Card'
create_payment_method 'Cash'
