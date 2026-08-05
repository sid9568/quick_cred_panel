class Dmt < ApplicationRecord
  has_many :dmt_transactions
  belongs_to :vendor_user, optional: true
end
