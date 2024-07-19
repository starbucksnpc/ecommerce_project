class User < ApplicationRecord
  belongs_to :province
  has_many :orders
  has_one :cart

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

end
