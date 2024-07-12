class ProductCategory < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "id_value", "product_id", "updated_at"]
  end
  
  belongs_to :product
  belongs_to :category
end
