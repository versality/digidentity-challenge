class User < ApplicationRecord
  has_one :account
  devise :database_authenticatable, :validatable
  after_create :create_account
end
