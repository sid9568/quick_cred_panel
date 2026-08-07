class AepsCommissionSlab < ApplicationRecord

 enum :service_type,
       {
         transaction: "transaction",
         mini_statement: "mini_statement",
         fund_settlement: "fund_settlement",
         balance_enquiry: "balance_enquiry"
       },
       prefix: :service

end
