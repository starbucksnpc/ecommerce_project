class Product < ApplicationRecord
  paginates_per 10

    def self.ransackable_associations(auth_object = nil)
        ["cart_items", "categories", "order_items", "product_categories"]
      end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "image_url", "name", "price", "sale_price", "stock_quantity", "updated_at"]
      end

      


  has_many_attached :images
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  def new_arrival?
    created_at >= 3.days.ago
  end

end
