class Api::V1::Agent::DmtsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

  def user_onboard
    required_params = %i[
    initiator_id
    pan_number
    mobile
    first_name
    last_name
    email
    dob
    shop_name
    residence_address
  ]

    missing = required_params.select { |key| params[key].blank? }
    if missing.any?
      return render json: {
        status: 0,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    # if params[:deposit_ifsc_code] && params[:deposit_ifsc_code]
    #   bank = Bank.find_by(deposit_account_no: params[:deposit_account_no], deposit_ifsc_code: params[:deposit_ifsc_code])
    # end
    response = EkoDmt::UserOnboardService.new(
      initiator_id: params[:initiator_id],
      pan_number: params[:pan_number],
      mobile: params[:mobile],
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      dob: params[:dob],
      shop_name: params[:shop_name],
      residence_address: params[:residence_address]
    ).call

    p "==========response=========="
    p response

    user_code = response.dig("data", "user_code") || response["user_code"]
    p "=========user_code=============="
    p user_code

    # ❌ No user_code → hard fail
    if user_code.blank?
      return render json: {
        status: 0,
        message: response[:message] || "User code not received from EKO",
        raw: response
      }, status: :unprocessable_entity
    end

    # ✅ SUCCESS OR ALREADY EXISTS → UPDATE USER
    current_user.update!(
      user_code: user_code,
      eko_onboard_first_step: true
    )

    render json: {
      status: 1,
      message: response[:message].presence || "User onboarded / already exists",
      user_code: user_code,
      eko_onboard_first_step: current_user.eko_onboard_first_step,
      data: response
    }, status: :ok
  end

  def create_customer
    resp = EkoDmt::DmtCustomerCreateService.new(
      customer_id:       current_user.phone_number,
      initiator_id:      "6268075916",
      user_code:         current_user.user_code,
      name:              params[:name],
      dob:               params[:dob],
      residence_address: params[:residence_address]
    ).call

    p "=====resp========"
    p resp

    render json: {
      status: resp["status"] || resp["response_status_id"],
      message: resp["message"],
      data: resp
    }
  end


  def check_profile
    customer_id  = params[:customer_id]
    user_code    = params[:user_code]

    if customer_id.blank? || user_code.blank?
      return render json: {
        status: false,
        message: "customer_id or user_code missing"
      }, status: :bad_request
    end

    response = EkoDmt::DmtCustomerProfileService.new(
      customer_id:  customer_id,
      user_code:    user_code
    ).call

    p "==========response========"
    p response

    status = response.dig("data", "status") || response["status"]
    p "=========status=============="
    p status

    if status == 0
      current_user.update(eko_profile_second_step: true)
    end

    render json: {
      status: response["status"] || response["response_status_id"],
      message: response["message"],
      data: response
    }
  end

# EKO_INITIATOR_ID = 6268075916
# EKO_USER_CODE = 20500001
# EKO_INITIATOR_ID = 6268075916
# EKO_USER_CODE = 38130001
  def biometric
    p "===============customer_id"
    csss =current_user.phone_number
    p "-----csss---------"
    p csss

    p "============current_user.user_code"
    p current_user.user_code

    p "======current_user.aadhaar_number======"
    p current_user.aadhaar_number

    result = Eko::BiometricEkycService.new(
      customer_id: current_user.phone_number,
      user_code: current_user.user_code,
      initiator_id: "6268075916",
      aadhar: current_user.aadhaar_number,
      piddata: params[:piddata] # RAW XML
    ).call
    render json: result
    p "===========result"
    p result
  end

  # def biometric
  #   p "===============customer_id"
  #   csss = current_user.phone_number
  #   result = Eko::BiometricEkycService.new(
  #     customer_id: params[:customer_id],
  #     user_code: "38130006",
  #     initiator_id: "6268075916",
  #     aadhar: "514204004154",
  #     piddata: params[:piddata] # RAW XML
  #   ).call
  #   render json: result
  #   p "===========result"
  #   p result
  # end

  def verify_otp
    required = %i[otp otp_ref_id kyc_request_id]

    missing = required.select { |k| params[k].blank? }
    if missing.any?
      return render json: {
        status: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    Rails.logger.info "========phone_number======="
    Rails.logger.info current_user.phone_number

    # ✅ WALLET CHECK (before API call)
    user_wallet = current_user.wallet
    unless user_wallet
      return render json: {
        status: false,
        message: "Wallet not found"
      }, status: :not_found
    end

    if user_wallet.balance.to_f < 10
      return render json: {
        status: false,
        message: "Insufficient wallet balance"
      }, status: :unprocessable_entity
    end

    # 🔹 Call EKO OTP Verify API
    resp = EkoDmt::DmtOtpVerifyService.new(
      customer_id:    current_user.phone_number,
      user_code:      current_user.user_code,
      initiator_id:   "6268075916",
      otp:            params[:otp],
      otp_ref_id:     params[:otp_ref_id],
      kyc_request_id: params[:kyc_request_id]
    ).call

    Rails.logger.info "========EKO OTP VERIFY RESPONSE========"
    Rails.logger.info resp.inspect

    status = resp.dig("data", "status") || resp["status"]
    # ✅ SUCCESS CASE
    if status == 0
      ActiveRecord::Base.transaction do
        current_user.update!(eko_biometric_kyc: true)
        user_wallet.update!(balance: user_wallet.balance.to_f - 10)
      end
    end

    description = resp.dig("data", "description") || resp["description"]

    success_descriptions = [
      "Customer Already registred ",
      "OTP Verified Successfully"
    ]

    if success_descriptions.include?(description)
      ActiveRecord::Base.transaction do
        current_user.update!(eko_biometric_kyc: true)
        user_wallet.update!(balance: user_wallet.balance.to_f - 10)
      end

      return render json: {
        status: true,
        message: description.strip,
        data: resp
      }
    end


    render json: {
      status: status,
      message: resp["message"] || "OTP verification completed",
      data: resp
    }
  end

  def verify_aadhaar
    result = EkoDmt::AadhaarOtpService.send_otp(
      initiator_id:  params[:initiator_id],
      user_code:     params[:user_code],
      aadhar:        params[:aadhar],
      access_key:    params[:access_key],
      realsourceip:  request.remote_ip
    )

    render json: result
  end


  def biometric_kyc
    customer_id = params[:customer_id]
    aadhar      = params[:aadhar]
    pidfile     = params[:piddata]

    return render json: { status: 0, message: "Missing Data" }, status: :bad_request if aadhar.blank? || pidfile.blank?

    # ✅ filename only
    pid_filename = pidfile.filename
    p "============pid_filename======"
    p pid_filename
    Rails.logger.info "PID Filename => #{pid_filename}"

    response = EkoBiometricKycService.biometric_kyc(
      customer_id,
      aadhar,
      pid_filename
    )

    render json: response
  end

  def create
    payload = {
      initiator_id: 9962981729,
      user_code: 20810200,
      customer_id: params[:customer_id],
      name: params[:name],
      dob: params[:dob],
      residence_address: params[:address]
    }

    response = DmtCustomerService.create_customer(payload)
    render json: response
  end

  # def verify_otp
  #   payload = {
  #     initiator_id: 9962981729,
  #     user_code: 20810200,
  #     customer_id: params[:customer_id],
  #     otp: params[:otp]
  #   }

  #   response = DmtCustomerService.verify_otp(payload)
  #   render json: response
  # end

  def biometric_ekyc_otp_verify
    p "-=============="
    p biometric_ekyc_otp_verify
    response = Eko::EkoBiometricEkycService.call(otp_params)

    render json: {
      message: response["message"],
      status: response["status"],
      data: response
    }, status: :ok
  end



  def bank_verify
    required = %i[ifsc account_number]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: {
        success: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    # 🔴 STEP 1: Already verified check
    existing_dmt = Dmt.find_by(
      account_number: params[:account_number],
      bank_verify_status: true,
      vendor_user_id: params[:id]
    )

    p "======existing_dmt========"
    p existing_dmt

    if existing_dmt.present?
      return render json: {
        success: true,
        message: "Bank account already verified",
        data: {
          account_number: existing_dmt.account_number,
          bank_name: existing_dmt.bank_name
        }
      }, status: :ok
    end

    # 🔵 STEP 2: Call EKO only if not verified
    response = EkoDmt::BankAccountVerifyService.new(
      ifsc: params[:ifsc].upcase,
      account_number: params[:account_number],
      initiator_id: "6268075916",
      customer_id:  "6268075916",
      user_code:    "38130001",
      client_ref_id: "BANKVERIFY#{Time.now.to_i}"
    ).call

    raw_body = response&.body.to_s
    Rails.logger.error "RAW EKO RESPONSE => #{raw_body}"

    parsed = JSON.parse(raw_body) rescue nil

    unless parsed && parsed["status"] == 0
      return render json: {
        success: false,
        message: parsed&.dig("message") || "EKO error",
        raw_response: raw_body
      }, status: :unprocessable_entity
    end

    # 🔵 STEP 3: Wallet deduction (FINTECH SAFE)
    fee = 3.0
    wallet = current_user.wallet

    return render json: {
      success: false,
      message: "Wallet not found"
    }, status: :unprocessable_entity unless wallet

    if wallet.balance.to_f < fee
      return render json: {
        success: false,
        message: "Insufficient wallet balance for bank verification"
      }, status: :unprocessable_entity
    end

    txn_id = "BANKVERIFY#{Time.current.to_i}"

    ActiveRecord::Base.transaction do
      # 🔻 Wallet fee debit
      debit_result = Wallets::WalletService.update_balance(
        wallet: wallet,
        amount: fee,
        transaction_type: "debit",
        remark: "Bank Verification Fee",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless debit_result[:success]

      # 🔹 Save verification status
      Dmt.create!(
        vendor_user_id: params[:id],
        account_number: params[:account_number],
        ifsc_code: params[:ifsc].upcase,
        bank_name: parsed.dig("data", "bank_name"),
        bank_verify_status: true
      )
    end

    render json: {
      success: true,
      message: "Bank account verified successfully. ₹3 has been deducted from your wallet.",
      data: parsed["data"],
      fee_deducted: fee,
      bank_verify: true,
      wallet_balance: wallet.reload.balance
    }, status: :ok

  rescue StandardError => e
    render json: {
      success: false,
      message: e.message
    }, status: :internal_server_error
  end



  def dmt_transactions_list
    dmt_transactions = DmtTransaction
    .where(user_id: current_user.id)
    .order(created_at: :desc)
    p "-=------------"
    p dmt_transactions
    render json: {
      code: 200,
      message: "Successfully fetched DMT transactions",
      dmts: dmt_transactions.map do |txn|
        dmt = txn.dmt
        {
          id: txn.id,
          txn_id: txn.txn_id,
          status: txn.status,
          amount: txn.amount,
          created_at: txn.created_at,
          tid: txn.tid,

          receiver_name: dmt&.receiver_name,
          receiver_mobile_number: dmt&.receiver_mobile_number,
          sender_mobile_number: dmt&.sender_mobile_number,
          sender_full_name: dmt&.sender_full_name,
          ifsc_code: dmt&.ifsc_code,
          branch_name: dmt&.branch_name,
          beneficiaries_status: dmt&.beneficiaries_status,
          parent_id: dmt&.parent_id,
          bank_name: dmt&.bank_name,
          account_number: dmt&.account_number,
        }
      end
    }, status: :ok
  end


  def all_beneficiary
    beneficiaries = Dmt.where(
      beneficiaries_status: true,
      user_id: current_user.id
    ).order(created_at: :desc)

    if beneficiaries.exists?
      render json: {
        code: 200,
        message: "Beneficiaries fetched successfully",
        beneficiaries: beneficiaries
      }
    else
      render json: {
        code: 404,
        message: "No beneficiaries found",
        beneficiaries: []
      }
    end
  end


  def beneficiary_list
    user = VendorUser.find_by(phone_number: params[:customer_id])
    p "======user======"
    if user.present?
      beneficiaries = Dmt.where(
        vendor_user_id: user.id,
        beneficiaries_status: true
      )
    else
      resp = EkoDmt::ListRecipientsService.call(
        sender_mobile: current_user.phone_number,
        initiator_id: "6268075916",
        user_code: current_user.user_code
      )

      # 👇 assume EKO response me beneficiaries yahan mil rahe hain
      beneficiaries = resp[:beneficiaries] || resp["beneficiaries"]
    end

    render json: {
      code: 200,
      message: "Successfully list show",
      beneficiaries: beneficiaries
    }
  end




  def sender_details
    required = %i[recipient_id amount]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: {
        success: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    # 🔹 Call EKO DMT Transfer
    resp = EkoDmt::TransferService.call(
      initiator_id: "6268075916",
      user_code: current_user.user_code,
      recipient_id: params[:recipient_id],
      amount: params[:amount],
      customer_id: current_user.phone_number
    )

    Rails.logger.info "========== EKO TRANSFER RESPONSE =========="
    Rails.logger.info

    # 🔹 Safely extract status
    status = resp.dig("data", "status") || resp[:status] || resp["status"]

    # ❌ If EKO failed
    if status.to_i != 0
      return render json: {
        success: false,
        message: resp.dig("data", "message") || resp[:message] || "Money transfer failed"
      }, status: :unprocessable_entity
    end

    # ✅ Success (OTP sent / transaction initiated)
    render json: {
      success: true,
      message: "OTP sent successfully to Aadhaar-linked mobile number.",
      transaction: resp[:data] || resp["data"]
    }, status: :ok
  end


  def verify_eko_otp
    required = %i[
    recipient_id
    amount
    customer_id
    otp
    otp_ref_id
  ]

    missing = required.select { |p| params[p].blank? }
    if missing.any?
      return render json: {
        success: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    resp = EkoDmt::FinoTransferService.call(
      initiator_id: "6268075916",
      user_code: current_user.user_code,
      recipient_id: params[:recipient_id],
      amount: params[:amount],
      customer_id: params[:customer_id],
      otp: params[:otp],
      otp_ref_id: params[:otp_ref_id],
      latlong: params[:latlong] || "28.6139,77.2090",
      client_ref_id: params[:client_ref_id] || "TXN#{Time.current.to_i}"
    )

    Rails.logger.info "========== EKO OTP VERIFY RESPONSE =========="
    Rails.logger.info resp

    if resp[:status] != 0
      return render json: {
        success: false,
        message: resp[:message] || "OTP verification failed"
      }, status: :unprocessable_entity
    end

    # ✅ SUCCESS
    render json: {
      success: true,
      message: "OTP verified successfully",
      transaction: resp[:data]
    }, status: :ok
  end


  def beneficiary_fetch
    if params[:mobile].blank?
      return render json: { success: false, message: "Missing: mobile" }, status: :bad_request
    end

    # ✅ Find the latest DMT record for this mobile where beneficiaries_status = true
    dmt = Dmt.where(receiver_mobile_number: params[:mobile], beneficiaries_status: true)
    .order(created_at: :desc)
    .first

    if dmt.present?
      render json: {
        code: 200,
        success: true,
        message: "Beneficiary details fetched successfully.",
        data: dmt.as_json(only: [:bank_name, :account_number, :confirm_account_number, :ifsc_code, :receiver_name])
      }, status: :ok
    else
      render json: { success: false, message: "No beneficiary found for this mobile number." }, status: :not_found
    end
  end


  def bank_list
    eko_banks = EkoBank.all
    render json: {code: 200, message: "bank list show", eko_bank: eko_banks}
  end


  # def dmt_transactions
  #   p "===========dmt_transactions============"
  #   required = %i[
  #   receiver_mobile_number account_number
  #   ifsc_code bank_name id
  # ]
  #   missing = required.select { |p| params[p].blank? }

  #   if missing.any?
  #     return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
  #   end

  #   # Validate account number
  #   # if params[:account_number].to_s.strip != params[:confirm_account_number].to_s.strip
  #   #   return render json: { success: false, message: "Account number and confirm account number do not match." }, status: :unprocessable_entity
  #   # end

  #   amount = params[:amount].to_f
  #   # beneficiaries_status = params[:beneficiary].present? && params[:beneficiary].to_s == "true"
  #   p "===================here======="

  #   ActiveRecord::Base.transaction do
  #     # ✅ Create DMT record
  #     dmt = Dmt.create!(
  #       sender_full_name: params[:sender_name],
  #       sender_mobile_number: params[:sender_mobile_number],
  #       receiver_name: params[:receiver_name],
  #       receiver_mobile_number: params[:receiver_mobile_number],
  #       account_number: params[:account_number],
  #       confirm_account_number: params[:confirm_account_number],
  #       ifsc_code: params[:ifsc_code],
  #       bank_name: params[:bank_name],
  #       branch_name: params[:branch_name],
  #       status: "pending",
  #       parent_id: current_user.parent_id,
  #       amount: amount,
  #       beneficiaries_status: true,
  #       bank_verify_status: false,
  #       vendor_id: params[:id],
  #     )

  #     # eko dmt transaction
  #     response = EkoDmt::AddRecipientService.call(
  #       sender_mobile: current_user.phone_number,
  #       initiator_id: "6268075916",
  #       user_code: current_user.user_code,
  #       recipient_mobile: params[:receiver_mobile_number],
  #       recipient_type: 3,
  #       recipient_name: params[:receiver_name],
  #       ifsc: params[:ifsc_code],
  #       account: params[:account_number],
  #       bank_id: params[:bank_id],
  #       account_type: 1
  #     )
  #     Rails.logger.info "========== EKO RESPONSE =========="
  #     Rails.logger.info response

  #     # ❗ Fail transaction if EKO failed


  #     status = response.dig("data", "status") || response["status"]
  #     p "=========status=============="
  #     p status

  #     recipient_id = response.dig("data", "recipient_id") || response["recipient_id"]


  #     if status != 0
  #       raise ActiveRecord::Rollback, "EKO recipient creation failed"
  #     end

  #     dmt.update!(
  #       recipient_id: recipient_id,
  #       status:       "recipient_added"
  #     )

  #     # ✅ Generate unique transaction ID
  #     txn_id = "TXN#{SecureRandom.hex(6).upcase}"

  #     # ✅ Create related DMT Transaction
  #     dmt_transaction = DmtTransaction.create!(
  #       dmt_id: dmt.id,
  #       user_id: current_user.id,
  #       txn_id: txn_id,
  #       sender_mobile_number: params[:sender_mobile_number],
  #       bank_name: params[:bank_name],
  #       account_number: params[:account_number],
  #       amount: amount,
  #       status: "pending"
  #     )

  #     render json: {
  #       success: true,
  #       message: "Beneficiary DMT transaction created successfully.",
  #       data: {
  #         dmt: dmt,
  #         dmt_transaction: dmt_transaction
  #       }
  #     }, status: :created

  #   rescue => e
  #     render json: { success: false, message: "Transaction failed: #{e.message}" }, status: :unprocessable_entity
  #   end
  # end

  def dmt_transactions
    p "========quick cred"
    required = %i[
    receiver_mobile_number account_number 
    ifsc_code bank_name id
  ]

    missing = required.select { |p| params[p].blank? }
    if missing.any?
      return render json: {
        success: false,
        message: "Missing: #{missing.join(', ')}"
      }, status: :bad_request
    end

    bank = EkoBank.find_by(name: params[:bank_name])
    p "===========bank============="
    p bank


    amount = params[:amount].to_f

    if current_user.user_code.blank?
      return render json: {
        success: false,
        message: "User code not found. Please contact support."
      }, status: :unprocessable_entity
    end

    # 🔹 1️⃣ CALL EKO FIRST
    response = EkoDmt::AddRecipientService.call(
      sender_mobile: current_user.phone_number,
      initiator_id: "6268075916",
      user_code: current_user.user_code,
      recipient_mobile: params[:receiver_mobile_number],
      recipient_type: 3,
      recipient_name: params[:receiver_name],
      ifsc: params[:ifsc_code],
      account: params[:account_number],
      bank_id: bank.bank_id,
      account_type: 1
    )

    Rails.logger.info "========== EKO RESPONSE =========="
    Rails.logger.info response

    status = response.dig("data", "status") || response["status"]

    p "=========status=========="
    p status

    # ❌ 2️⃣ STOP EXECUTION IF EKO FAILED
    if status != 0
      return render json: {
        success: false,
        message: response.dig("data", "message") || "EKO recipient creation failed"
      }, status: :unprocessable_entity
    end

    vendor_user = VendorUser.find_by(id: params[:id])

    recipient_id = response.dig("data", "recipient_id") || response["recipient_id"]

    bank_verify_status = params[:bank_verify].to_s == "true"
    txn_id = "TXN#{rand(100000..999999)}"

    # 🔹 3️⃣ DB TRANSACTION ONLY AFTER SUCCESS
    ActiveRecord::Base.transaction do
      dmt = Dmt.create!(
        sender_full_name: vendor_user.full_name,
        sender_mobile_number: vendor_user.phone_number,
        receiver_name: params[:receiver_name],
        receiver_mobile_number: params[:receiver_mobile_number],
        account_number: params[:account_number],
        confirm_account_number: params[:confirm_account_number],
        ifsc_code: params[:ifsc_code],
        bank_name: params[:bank_name],
        user_id: current_user.id,
        branch_name: params[:branch_name],
        status: "recipient_added",
        parent_id: current_user.parent_id,
        amount: amount,
        beneficiaries_status: true,
        bank_verify_status: bank_verify_status,
        vendor_user_id: vendor_user.id,
        recipient_id: recipient_id,
        txn_id: txn_id
      )

      render json: {
        success: true,
        message: "Beneficiary added & DMT transaction created successfully",
        data: {
          dmt: dmt,
          dmt_transaction: dmt
        }
      }, status: :created
    end

  rescue => e
    render json: {
      success: false,
      message: "Transaction failed: #{e.message}"
    }, status: :unprocessable_entity
  end



  def send_otp

  end


  def dmt_transaction_verify
  Rails.logger.info "=" * 60
  Rails.logger.info "========== DMT TRANSACTION VERIFY START =========="
  Rails.logger.info "=" * 60
  Rails.logger.info "Params: #{params.inspect}"
  Rails.logger.info "Current User: #{current_user.id} - #{current_user.username} - Role: #{current_user.role&.title}"
  
  # if params[:otp].blank?
  #   return render json: { success: false, message: "otp is required" }, status: :bad_request
  # end

  required = %i[
    otp recipient_id amount customer_id otp_ref_id
  ]

  missing = required.select { |p| params[p].blank? }
  if missing.any?
    Rails.logger.warn "Missing params: #{missing.join(', ')}"
    return render json: {
      success: false,
      message: "Missing params: #{missing.join(', ')}"
    }, status: :bad_request
  end

  hierarchy = current_user.find_hierarchy
  Rails.logger.info "=" * 60
  Rails.logger.info "====== HIERARCHY ======"
  Rails.logger.info "Hierarchy IDs: #{hierarchy.pluck(:id).inspect}"
  hierarchy.each_with_index do |user, idx|
    Rails.logger.info "Hierarchy[#{idx}]: User##{user.id} - #{user.role&.title} - #{user.username} (Parent: #{user.parent_id})"
  end
  Rails.logger.info "=" * 60

  # EKO API CALL - DO NOT MODIFY
  # Rails.logger.info "Calling EKO API for transaction verification..."
  # response = EkoDmt::FinoTransferService.call(
  #   initiator_id: "6268075916",
  #   user_code: current_user.user_code,
  #   recipient_id: params[:recipient_id],
  #   amount: params[:amount],
  #   customer_id: current_user.phone_number,
  #   otp: params[:otp],
  #   otp_ref_id: params[:otp_ref_id],
  #   latlong: params[:latlong] || "28.6139,77.2090",
  #   client_ref_id: params[:client_ref_id] || "TXN#{Time.current.to_i}"
  # )

  # Rails.logger.info "=" * 60
  # Rails.logger.info "========== EKO OTP VERIFY RESPONSE =========="
  # Rails.logger.info "Response: #{response.inspect}"
  # Rails.logger.info "=" * 60

  # eko_reason = response.dig("data", "reason") || response["reason"]
  # Rails.logger.info "EKO Reason: #{eko_reason}"
  
  # if eko_reason == "OTP Verification failed"
  #   Rails.logger.error "OTP Verification failed!"
  #   return render json: {
  #     success: false,
  #     message: response[:message] || "OTP Verification failed"
  #   }, status: :unprocessable_entity
  # end

  # eko_status = response.dig("data", "status") || response["status"]
  # Rails.logger.info "EKO Status: #{eko_status}"
  
  # # ❌ OTP / transfer failed
  # if eko_status != 0
  #   Rails.logger.error "EKO transaction failed with status: #{eko_status}"
  #   return render json: {
  #     success: false,
  #     message: response[:message] || "Amount Greater Than 100"
  #   }, status: :unprocessable_entity
  # end

  amount = params[:amount].to_f
  Rails.logger.info "Transaction Amount: ₹#{amount}"

  #======================Dmt===============
  dmt = Dmt.find_by(id: params[:id])
  Rails.logger.info "=" * 60
  Rails.logger.info "========== DMT RECORD =========="
  Rails.logger.info "DMT ID: #{dmt&.id}"
  Rails.logger.info "DMT Status: #{dmt&.status}"
  
  if dmt.nil?
    Rails.logger.error "DMT not found with ID: #{params[:id]}"
    return render json: { success: false, message: "DMT record not found" }, status: :not_found
  end
  
  dmt.update!(status: "Success")
  Rails.logger.info "DMT ##{dmt.id} status updated to Success"
  #======================Dmt===============

  # 🔥 STEP 1: FETCH COMMISSION SLAB
  Rails.logger.info "=" * 60
  Rails.logger.info "========== FETCHING COMMISSION SLAB =========="
  dmt_surcharge = DmtCommissionSlabRange.find_by(
    "min_amount <= ? AND max_amount >= ?",
    amount, amount
  )
  
  if dmt_surcharge.nil?
    Rails.logger.error "No commission slab found for amount: #{amount}"
    return render json: { success: false, message: "Commission slab not found" }, status: :unprocessable_entity
  end
  
  Rails.logger.info "Commission Slab Found:"
  Rails.logger.info "  Min Amount: ₹#{dmt_surcharge.min_amount}"
  Rails.logger.info "  Max Amount: ₹#{dmt_surcharge.max_amount}"
  Rails.logger.info "  Surcharge: ₹#{dmt_surcharge.surcharge}"
  Rails.logger.info "  TDS Percent: #{dmt_surcharge.tds_percent}%"
  Rails.logger.info "  GST Percent: #{dmt_surcharge.gst_percent}%"

  commission_eko = dmt_surcharge.surcharge.to_f
  Rails.logger.info "EKO Commission Available: ₹#{commission_eko}"

  # Build role hierarchy chain from current_user up to top
  Rails.logger.info "=" * 60
  Rails.logger.info "========== BUILDING ROLE CHAIN =========="
  role_chain = []
  
  # Start with current user (retailer)
  role_chain << {
    role: "retailer",
    user: current_user,
    scheme_id: current_user.scheme_id
  }
  Rails.logger.info "Added to chain: RETAILER - User##{current_user.id} (Scheme: #{current_user.scheme_id})"
  
  # Add parent users from hierarchy
  hierarchy.each_with_index do |parent, idx|
    role = parent.role.title.downcase
    role_chain << {
      role: role,
      user: parent,
      scheme_id: parent.scheme_id
    }
    Rails.logger.info "Added to chain: #{role.upcase} - User##{parent.id} (Scheme: #{parent.scheme_id})"
  end
  
  Rails.logger.info "Total roles in chain: #{role_chain.length}"
  Rails.logger.info "Role Chain Order: #{role_chain.map { |r| r[:role].upcase }.join(' → ')}"

  # Fetch FLAT commission amounts for each role
  Rails.logger.info "=" * 60
  Rails.logger.info "========== FETCHING FLAT COMMISSION AMOUNTS =========="
  role_chain.each do |item|
    commission_flat = DmtCommissionSlab.find_by(
      scheme_id: item[:scheme_id],
      to_role: item[:role]
    )&.value.to_f
    
    item[:commission_flat] = commission_flat
    Rails.logger.info "#{item[:role].upcase} (User##{item[:user].id}): Flat Commission = ₹#{commission_flat}"
  end

  # Calculate total flat commission required
  Rails.logger.info "=" * 60
  Rails.logger.info "========== CALCULATING FLAT COMMISSIONS =========="
  commission_map = {}
  total_flat_commission = 0
  
  role_chain.each_with_index do |current, index|
    current_role = current[:role].upcase
    flat_amount = current[:commission_flat]
    
    Rails.logger.info "Processing #{current_role}: Flat Commission = ₹#{flat_amount}"
    
    commission_map[current[:role].to_sym] = {
      user_id: current[:user].id,
      user: current[:user],
      role: current[:role],
      commission_amount: flat_amount
    }
    
    total_flat_commission += flat_amount
    Rails.logger.info "  ✅ #{current_role} will get: ₹#{flat_amount}"
    Rails.logger.info "-" * 40
  end

  # Distribute remaining EKO commission to ADMIN
  Rails.logger.info "=" * 60
  Rails.logger.info "========== DISTRIBUTING REMAINING COMMISSION TO ADMIN =========="
  Rails.logger.info "Total Flat Commission Required: ₹#{total_flat_commission}"
  Rails.logger.info "EKO Commission Available: ₹#{commission_eko}"
  
  remaining_commission = commission_eko - total_flat_commission
  
  if remaining_commission > 0
    Rails.logger.info "Remaining Commission: ₹#{remaining_commission}"
    Rails.logger.info "Adding remaining commission to ADMIN"
    
    if commission_map[:admin]
      old_admin_commission = commission_map[:admin][:commission_amount]
      commission_map[:admin][:commission_amount] += remaining_commission
      Rails.logger.info "Admin commission updated: ₹#{old_admin_commission} → ₹#{commission_map[:admin][:commission_amount]}"
    else
      admin_user = role_chain.find { |r| r[:role] == "admin" }
      if admin_user
        commission_map[:admin] = {
          user_id: admin_user[:user].id,
          user: admin_user[:user],
          role: "admin",
          commission_amount: remaining_commission
        }
        Rails.logger.info "Admin added to commission map with ₹#{remaining_commission}"
      end
    end
  elsif remaining_commission < 0
    Rails.logger.warn "⚠️ Commission exceeds EKO limit by ₹#{-remaining_commission}"
    excess = -remaining_commission
    old_retailer_commission = commission_map[:retailer][:commission_amount]
    commission_map[:retailer][:commission_amount] = [commission_map[:retailer][:commission_amount] - excess, 0].max
    Rails.logger.info "Retailer commission adjusted: ₹#{old_retailer_commission} → ₹#{commission_map[:retailer][:commission_amount]}"
  else
    Rails.logger.info "✅ Perfect match! No remaining commission"
  end

  # Recalculate total after adjustments
  new_total = commission_map.values.sum { |v| v[:commission_amount] }
  Rails.logger.info "New Total Commission: ₹#{new_total}"
  Rails.logger.info "EKO Commission Used: ₹#{new_total}"
  Rails.logger.info "Remaining with EKO: ₹#{commission_eko - new_total}"

  Rails.logger.info "=" * 60
  Rails.logger.info "========== FINAL COMMISSION MAP =========="
  commission_map.each do |role, data|
    Rails.logger.info "#{role.upcase}: ₹#{data[:commission_amount]} (User #{data[:user_id]})"
  end
  Rails.logger.info "=" * 60

  # 🔥 STEP 2: Process Wallet Transaction - ONLY USING WalletService
  Rails.logger.info "=" * 60
  Rails.logger.info "========== PROCESSING WALLET TRANSACTION =========="
  wallet = Wallet.find_by(user_id: current_user.id)
  unless wallet
    Rails.logger.error "Wallet not found for user: #{current_user.id}"
    return render json: { success: false, message: "Wallet not found" }, status: :not_found
  end

  Rails.logger.info "Current User Wallet:"
  Rails.logger.info "  Wallet ID: #{wallet.id}"
  Rails.logger.info "  Balance: ₹#{wallet.balance.to_f}"
  Rails.logger.info "  Amount to Debit: ₹#{params[:amount].to_f}"

  # Check sufficient balance
  if wallet.balance.to_f < params[:amount].to_f
    Rails.logger.warn "Insufficient balance! Available: ₹#{wallet.balance.to_f}, Required: ₹#{params[:amount].to_f}"
    return render json: { success: false, message: "Insufficient wallet balance" }, status: :unprocessable_entity
  end

  # Perform transaction safely - ONLY using WalletService
  dmt_transaction = nil

  Rails.logger.info "Starting database transaction..."
  ActiveRecord::Base.transaction do
    # Calculate main amount to debit
    main_amount = params[:amount].to_f + dmt_surcharge.surcharge + dmt_surcharge.tds_percent + dmt_surcharge.gst_percent
    Rails.logger.info "Main Amount to Debit: ₹#{main_amount}"
    Rails.logger.info "  Breakdown:"
    Rails.logger.info "    Base Amount: ₹#{params[:amount]}"
    Rails.logger.info "    Surcharge: ₹#{dmt_surcharge.surcharge}"
    Rails.logger.info "    TDS: ₹#{dmt_surcharge.tds_percent}"
    Rails.logger.info "    GST: ₹#{dmt_surcharge.gst_percent}"
    
    # 1. First debit the main amount from retailer's wallet
    debit_result = Wallets::WalletService.update_balance(
      wallet: wallet,
      amount: main_amount,
      transaction_type: "debit",
      remark: "DMT Main Amount Debit",
      reference_id: "MAIN_#{params[:id]}"
    )
    
    unless debit_result[:success]
      Rails.logger.error "Main debit failed: #{debit_result[:error]}"
      raise ActiveRecord::Rollback, "Main debit failed: #{debit_result[:error]}"
    end
    Rails.logger.info "  ✅ Main amount debited: ₹#{main_amount}"
    Rails.logger.info "  New Balance: ₹#{wallet.reload.balance.to_f}"

    # Generate transaction ID
    txn_id = "TXN#{rand(100000..999999)}"
    Rails.logger.info "Generated Transaction ID: #{txn_id}"

    # 2. Process surcharge credit back to retailer
    surcharge_result = Wallets::WalletService.update_balance(
      wallet: wallet,
      amount: params[:amount].to_f,
      transaction_type: "credit",
      remark: "DMT Commission Credit",
      reference_id: txn_id
    )
    Rails.logger.info "  ✅ Surcharge credit: ₹#{params[:amount]}"

    # 3. Process TDS debit
    tds_result = Wallets::WalletService.update_balance(
      wallet: wallet,
      amount: dmt_surcharge.tds_percent,
      transaction_type: "debit",
      remark: "DMT TDS",
      reference_id: "hjhd8789798"
    )
    Rails.logger.info "  ✅ TDS debit: ₹#{dmt_surcharge.tds_percent}"

    # 4. Process GST debit
    gst_result = Wallets::WalletService.update_balance(
      wallet: wallet,
      amount: dmt_surcharge.gst_percent,
      transaction_type: "debit",
      remark: "Dmt Gst",
      reference_id: "707dds8"
    )
    Rails.logger.info "  ✅ GST debit: ₹#{dmt_surcharge.gst_percent}"

    # 5. Create DMT transaction record
    dmt_transaction = DmtTransaction.create!(
      dmt_id: dmt.id,
      user_id: current_user.id,
      txn_id: txn_id,
      sender_mobile_number: params[:sender_mobile_number],
      bank_name: params[:bank_name],
      account_number: params[:account_number],
      amount: amount,
      status: "success",
      # fee: response.dig("data", "fee"),
      # tid: response.dig("data", "tid"),
      # tds: response.dig("data", "tds"),
      # service_tax: response.dig("data", "service_tax"),
      # commission: response.dig("data", "commission"),
      # txstatus_desc: response.dig("data", "txstatus_desc"),
      # collectable_amount: response.dig("data", "collectable_amount")
    )
    
    Rails.logger.info "✅ DMT Transaction created: ID ##{dmt_transaction.id}"
    
    # Update DMT record
    dmt.update(amount: main_amount, transaction_status: true)
    Rails.logger.info "✅ DMT ##{dmt.id} updated - Amount: ₹#{main_amount}"
  end
  Rails.logger.info "Database transaction completed successfully"

  # === Helper method to find or create wallet ===
  def find_or_create_wallet(user)
    wallet = Wallet.find_by(user_id: user.id)
    if wallet.nil?
      Rails.logger.info "Wallet not found for user #{user.id}, creating new wallet..."
      wallet = Wallet.create!(
        user_id: user.id,
        balance: 0.0,
        currency: "INR"
      )
      Rails.logger.info "✅ Wallet created for user #{user.id} with ID #{wallet.id}"
    end
    wallet
  end

  # === Distribute Flat Commission to all roles in hierarchy ===
  Rails.logger.info "=" * 60
  Rails.logger.info "========== DISTRIBUTING FLAT COMMISSIONS =========="
  Rails.logger.info "=" * 60
  
  commission_count = 0
  total_distributed = 0
  
  commission_map.each do |role, commission_data|
    next if commission_data[:commission_amount] <= 0
    
    user = commission_data[:user]
    commission_amount = commission_data[:commission_amount]
    
    Rails.logger.info "-" * 40
    Rails.logger.info "Crediting Commission to: #{role.upcase}"
    Rails.logger.info "  User ID: #{user.id}"
    Rails.logger.info "  Username: #{user.username}"
    Rails.logger.info "  Role: #{user.role&.title}"
    Rails.logger.info "  Flat Commission Amount: ₹#{commission_amount}"
    
    # Find or create wallet for user
    user_wallet = find_or_create_wallet(user)
    Rails.logger.info "  Wallet ID: #{user_wallet.id}"
    Rails.logger.info "  Current Balance: ₹#{user_wallet.balance.to_f}"
    
    # Credit commission using WalletService
    result = Wallets::WalletService.update_balance(
      wallet: user_wallet,
      amount: commission_amount,
      transaction_type: "credit",
      remark: "DMT Flat Commission - #{role.to_s.upcase}",
      reference_id: "33232dsdd"
    )
    
    if result[:success]
      Rails.logger.info "✅ SUCCESS: #{role.upcase} (User #{user.id}) credited ₹#{commission_amount}"
      
      # Create commission record
      DmtCommission.create!(
        dmt_id: dmt.id,
        user_id: user.id,
        commission_amount: commission_amount,
        role: role.to_s,
      )
      
      commission_count += 1
      total_distributed += commission_amount
    else
      Rails.logger.error "❌ FAILED: Commission credit failed for #{role.upcase} (User #{user.id})"
      Rails.logger.error "  Error: #{result[:error]}"
    end
  end
  
  Rails.logger.info "=" * 60
  Rails.logger.info "========== FLAT COMMISSION DISTRIBUTION SUMMARY =========="
  Rails.logger.info "Total Roles Credited: #{commission_count}"
  Rails.logger.info "Total Commission Distributed: ₹#{total_distributed}"
  Rails.logger.info "EKO Commission Available: ₹#{commission_eko}"
  Rails.logger.info "Remaining EKO Commission: ₹{(commission_eko - total_distributed)}"
  Rails.logger.info "=" * 60

  # Final response
  Rails.logger.info "=" * 60
  Rails.logger.info "========== TRANSACTION COMPLETED SUCCESSFULLY =========="
  Rails.logger.info "=" * 60
  
  render json: {
    code: "200",
    success: true,
    message: "Transaction completed successfully",
    data: {
      transaction: dmt_transaction,
      bank_name: dmt_transaction.bank_name,
      remaining_balance: wallet.reload.balance,
      commission_distributed: {
        total: total_distributed,
        eko_commission: commission_eko,
        remaining: (commission_eko - total_distributed),
        breakdown: commission_map.map { |role, data| 
          {
            role: role,
            user_id: data[:user_id],
            amount: data[:commission_amount]
          }
        }
      }
    }
  }, status: :ok

rescue ActiveRecord::RecordInvalid => e
  Rails.logger.error "=" * 60
  Rails.logger.error "❌ TRANSACTION FAILED - RecordInvalid"
  Rails.logger.error "Error: #{e.message}"
  Rails.logger.error "Record: #{e.record.inspect}"
  Rails.logger.error "Errors: #{e.record.errors.full_messages.join(', ')}"
  Rails.logger.error "=" * 60
  render json: { success: false, message: "Transaction failed: #{e.message}" }, status: :unprocessable_entity
  
rescue => e
  Rails.logger.error "=" * 60
  Rails.logger.error "❌ UNEXPECTED ERROR"
  Rails.logger.error "Error: #{e.message}"
  Rails.logger.error "Error Class: #{e.class}"
  Rails.logger.error "Backtrace:"
  Rails.logger.error e.backtrace.join("\n")
  Rails.logger.error "=" * 60
  render json: { success: false, message: "Something went wrong: #{e.message}" }, status: :internal_server_error
end


end
