class Dmt < ApplicationRecord
  has_many :dmt_transactions
  belongs_to :vendor, class_name: "User", foreign_key: "vendor_id", optional: true
  has_many :dmts, foreign_key: "vendor_id"
end
