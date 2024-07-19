class OrderItem < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "order_id", "product_id", "quantity", "unit_price", "updated_at"]
  end
  
  belongs_to :order
  belongs_to :product

end
