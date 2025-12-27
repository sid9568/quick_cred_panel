module EkoDmt
  class DmtCommissionCreator
    GST_PERCENT = 18.0

    def self.call(user:, amount:, scheme:)
      amount = amount.to_f

      # 🔹 Step 1: Find applicable slab
      slab = DmtCommissionSlab
      .where(active: true, scheme: scheme)
      .where("min_amount <= ? AND max_amount >= ?", amount, amount)
      .first

      raise "DMT commission slab not found" if slab.nil?

      # 🔹 Step 2: Calculations
      bank_fee = (amount * slab.bank_fee_percent / 100.0).round(2)
      bank_fee_net_gst = (bank_fee / (1 + GST_PERCENT / 100)).round(2)

      gross_commission = (bank_fee_net_gst - slab.eko_fee).round(2)
      tds_amount = (gross_commission * slab.tds_percent / 100.0).round(2)
      net_commission = (gross_commission - tds_amount).round(2)

      customer_paid = (amount + slab.surcharge).round(2)

      # 🔹 Step 3: Create transaction
      DmtTransaction.create!(
        amount: amount,

        applied_surcharge: slab.surcharge,
        customer_paid: customer_paid,

        bank_fee: bank_fee,
        bank_fee_net_gst: bank_fee_net_gst,
        eko_fee: slab.eko_fee,

        gross_commission: gross_commission,
        tds_amount: tds_amount,
        net_commission: net_commission,

        status: "success"
      )
    end
  end
end
