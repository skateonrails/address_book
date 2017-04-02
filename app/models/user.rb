class User < ApplicationRecord
  has_secure_password
  validates :password, :length => { :minimum => 5 }
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, presence: true
end
