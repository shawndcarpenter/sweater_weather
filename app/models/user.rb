class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :email
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
end