class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy

  def total
    total = 0
    order_items.each do |item|
      total += item.subtotal
    end
    return total
  end

end
