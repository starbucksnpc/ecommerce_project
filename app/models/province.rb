class Province < ApplicationRecord
    has_many :users
    has_many :orders  

    # Validations
  validates :name, presence: true, uniqueness: true
  validates :gst_rate, :pst_rate, :hst_rate, :qst_rate, numericality: { greater_than_or_equal_to: 0 }

end
