class AddSlabRangeRefToDmtCommissionSlabs < ActiveRecord::Migration[7.2]
  def change
    add_reference :dmt_commission_slabs, :dmt_commission_slab_range, null: false, foreign_key: true
  end
end
