class CreateAcceptedPaymentMethods < ActiveRecord::Migration

  def change
    create_table :accepted_payment_methods do |t|
      t.references :restaurant
      t.references :payment_method
    end
  end

end
