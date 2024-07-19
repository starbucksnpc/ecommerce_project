class Category < ApplicationRecord

    def self.ransackable_associations(auth_object = nil)
        ["product_categories", "products"]
      end

      def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "name", "updated_at"]
      end


    has_many :product_categories
    has_many :products, through: :product_categories

    # Validations
  validates :name, presence: true, uniqueness: true
end
