class Scheme < ApplicationRecord
  # has_many :users , dependent: :destroy
  belongs_to :user
  has_many :dmt_commission_slabs, dependent: :destroy

  has_many :commissions, dependent: :destroy
end
