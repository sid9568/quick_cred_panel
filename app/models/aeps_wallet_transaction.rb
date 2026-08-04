class AepsWalletTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :aeps_wallet
end
