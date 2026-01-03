class Superadmin::AccountsController < Superadmin::BaseController

  def index
    @account_transaction = AccountTransaction.where(parent_id: current_superadmin.id, txn_type: "Credit").order(created_at: :desc)
  end

  def new
  end

  def add_credit
    super_admin = current_superadmin

    @user = User.find_by(
      username: params[:username],
      phone_number: params[:phone_number]
    )

    unless @user
      return redirect_to superadmin_accounts_index_path, alert: "User not found"
    end

    unless params[:set_pin] == super_admin.set_pin
      return redirect_to superadmin_accounts_index_path, alert: "Invalid PIN"
    end

    amount = params[:amount].to_f
    reason = params[:reason]

    user_wallet   = @user.wallet || @user.create_wallet(balance: 0)
    parent_wallet = super_admin.wallet || super_admin.create_wallet(balance: 0)

    if parent_wallet.balance.to_f < amount
      return redirect_to superadmin_accounts_index_path, alert: "Insufficient balance"
    end

    txn_id = "TXN#{SecureRandom.hex(4).upcase}"

    ActiveRecord::Base.transaction do
      # 🔻 Parent wallet debit
      parent_result = Wallets::WalletService.update_balance(
        wallet: parent_wallet,
        amount: amount,
        transaction_type: "debit",
        remark: "Admin Wallet Transfer",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless parent_result[:success]

      # 🔺 User wallet credit
      user_result = Wallets::WalletService.update_balance(
        wallet: user_wallet,
        amount: amount,
        transaction_type: "credit",
        remark: "Admin Wallet Credit",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless user_result[:success]

      # 📒 Account transaction log
      AccountTransaction.create!(
        txn_id: txn_id,
        mobile: @user.phone_number,
        amount: amount,
        reason: reason,
        wallet_id: user_wallet.id,
        txn_type: "credit",
        user_id: @user.id,
        status: "success",
        parent_id: super_admin.id
      )
    end

    redirect_to superadmin_accounts_index_path, notice: "Amount credited successfully"

  rescue StandardError => e
    redirect_to superadmin_accounts_index_path, alert: e.message
  end


  def debit_index
    @account_transaction =  AccountTransaction.where(parent_id: current_superadmin.id, txn_type: "Debit").order(created_at: :desc)
  end

  def add_debit
    super_admin = current_superadmin

    @user = User.find_by( username: params[:username],
      phone_number: params[:phone_number])
    unless @user
      return redirect_to superadmin_accounts_debit_index_path,
        alert: "User not found"
    end

    unless params[:set_pin] == super_admin.set_pin
      return redirect_to superadmin_accounts_debit_index_path,
        alert: "Invalid PIN"
    end

    amount = params[:amount].to_f
    if amount <= 0
      return redirect_to superadmin_accounts_debit_index_path,
        alert: "Invalid amount"
    end

    user_wallet   = @user.wallet || @user.create_wallet(balance: 0)
    parent_wallet = super_admin.wallet || super_admin.create_wallet(balance: 0)
    p "========user_wallet========="
    p user_wallet
    # 🔴 User ke paas balance hona chahiye
    if user_wallet.balance.to_f < amount
      return redirect_to superadmin_accounts_debit_index_path,
        alert: "Insufficient balance"
    end

    txn_id = "TXN#{SecureRandom.hex(4).upcase}"

    ActiveRecord::Base.transaction do
      # 🔻 User wallet debit
      user_result = Wallets::WalletService.update_balance(
        wallet: user_wallet,
        amount: amount,
        transaction_type: "debit",
        remark: "Wallet Debit by Admin",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless user_result[:success]

      # 🔺 Admin wallet credit
      parent_result = Wallets::WalletService.update_balance(
        wallet: parent_wallet,
        amount: amount,
        transaction_type: "credit",
        remark: "Admin Wallet Credit from User",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless parent_result[:success]

      # 📒 Account transaction log
      AccountTransaction.create!(
        txn_id: txn_id,
        mobile: @user.phone_number,
        amount: amount,
        reason: params[:reason],
        wallet_id: user_wallet.id,
        txn_type: "debit",
        user_id: @user.id,
        status: "success",
        parent_id: super_admin.id
      )
    end

    redirect_to superadmin_accounts_debit_index_path,
      notice: "Amount debited successfully"

  rescue StandardError => e
    redirect_to superadmin_accounts_debit_index_path,
      alert: e.message
  end






end
