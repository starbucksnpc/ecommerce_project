class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy

   # Validations
   validates :address, presence: true
   validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
   validates :status, presence: true
   validates :province_id, presence: true


  def calculate_total_price(cart)
    self.total_price = cart.sum { |product_id, quantity| Product.find(product_id).price * quantity }
  end

  def calculate_taxes(cart)
    province = self.province
    gst_rate = province.gst_rate || 0
    pst_rate = province.pst_rate || 0
    hst_rate = province.hst_rate || 0
    qst_rate = province.qst_rate || 0

    self.gst = cart.sum { |product_id, quantity| Product.find(product_id).price * quantity * gst_rate }
    self.pst = cart.sum { |product_id, quantity| Product.find(product_id).price * quantity * pst_rate }
    self.hst = cart.sum { |product_id, quantity| Product.find(product_id).price * quantity * hst_rate }
    self.qst = cart.sum { |product_id, quantity| Product.find(product_id).price * quantity * qst_rate }
  end

  def total_tax
    (gst || 0) + (pst || 0) + (qst || 0) + (hst || 0)
  end

  def total_with_tax
    (total_price || 0) + total_tax
  end
end