class AepsWalletTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :aeps_wallet

  def user_name
    user&.full_name
  end
  
end
