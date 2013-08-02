class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  validates :order_id, presence: true
  validates :product_id, presence: true
  validates_presence_of :quantity
  validates_numericality_of :quantity, :only_integer => true, :allow_nil => false
  
  def subtotal
    product.price * quantity.to_i
  end

end
