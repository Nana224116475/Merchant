class Product < ActiveRecord::Base
  validates_numericality_of :price
  validates :stock, presence: true
end
