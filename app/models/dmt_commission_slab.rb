class DmtCommissionSlab < ApplicationRecord
  belongs_to :scheme, optional: true
  belongs_to :dmt_commission_slab_range
end
