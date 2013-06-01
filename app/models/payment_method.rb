class PaymentMethod < ActiveRecord::Base
  has_and_belongs_to_many :payment_method, :join_table => :accepted_payment_methods

  attr_accessible :logo_url, :name
end
