class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :email
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  def create_api_key
    self.api_key = SecureRandom.hex
  end
end