class User < ActiveRecord::Base
  belongs_to :group
  attr_accessible :avatar_url, :email, :first_name, :last_name
end
