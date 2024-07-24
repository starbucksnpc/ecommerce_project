class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy

   # Validations
   validates :address, presence: true
   validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
   validates :status, presence: true

   def calculate_total
    self.total_price = order_items.sum { |item| item.unit_price * item.quantity } + gst + pst + hst + qst
  end
  
end
