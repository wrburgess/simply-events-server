class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true
  validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
