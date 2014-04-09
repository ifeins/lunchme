class PaymentMethod < ActiveRecord::Base
  has_and_belongs_to_many :restaurants, :join_table => :accepted_payment_methods
end
