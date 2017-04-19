class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :organizations

  validates :password, length: { minimum: 5 }
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: /.+@.+\..+/i }
end
