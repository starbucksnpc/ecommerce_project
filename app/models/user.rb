class User < ApplicationRecord
  belongs_to :province
  has_many :orders
  has_one :cart
end
