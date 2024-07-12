class Product < ApplicationRecord

    def self.ransackable_associations(auth_object = nil)
        ["cart_items", "categories", "order_items", "product_categories"]
      end
      
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "image_url", "name", "new_arrival", "price", "sale_price", "stock_quantity", "updated_at"]
      end


  has_many :order_items
  has_many :cart_items
  has_many :product_categories
  has_many :categories, through: :product_categories
end
