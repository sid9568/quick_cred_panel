class VendorUser < ApplicationRecord
  has_many :dmts, dependent: :nullify
end
