require 'active_record'

class UserItem < ActiveRecord::Base
  has_one :user
end