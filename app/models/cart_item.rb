class CartItem < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "id", "id_value", "product_id", "quantity", "updated_at"]
  end
  
  belongs_to :cart
  belongs_to :product
end
