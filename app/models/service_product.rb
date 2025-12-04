class ServiceProduct < ApplicationRecord
  belongs_to :category
  has_many :transactions, dependent: :destroy
  has_many :service_product_items
end
