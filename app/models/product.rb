class Product < ActiveRecord::Base
  has_many :order_items
  validates_numericality_of :price
  validates :stock, presence: true
end
