class User < ActiveRecord::Base
  has_many :user_items, inverse_of: :user
end