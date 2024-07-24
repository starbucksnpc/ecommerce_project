class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

   # Validations
   validates :user, presence: true, uniqueness: true
end
