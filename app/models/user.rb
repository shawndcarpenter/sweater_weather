class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :email
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  # validate :matching_passwords

  # def matching_passwords
  #   if password != password_confirmation
  #     errors.add(:password_confirmation, "must match password")
  #   end
  # end
end