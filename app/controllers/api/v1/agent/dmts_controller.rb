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
      customer_id:       params[:customer_id],
      initiator_id:      params[:initiator_id],
      user_code:         params[:user_code],
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
      initiator_id: "9212094999",
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
  #     initiator_id: "9212094999",
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
      initiator_id:   "9212094999",
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
      initiator_id: "9212094999",
      customer_id:  "9212094999",
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


  def sender_beneficiary
    user = User.find_by(phone_number: params[:customer_id])
  end

  def beneficiary_list
    user = VendorUser.find_by(phone_number: params[:customer_id])

    if user.present?
      beneficiaries = Dmt.where(
        vendor_user_id: user.id,
        beneficiaries_status: true
      )
    else
      resp = EkoDmt::ListRecipientsService.call(
        sender_mobile: current_user.phone_number,
        initiator_id: "9212094999",
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
      initiator_id: "9212094999",
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
      initiator_id: "9212094999",
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
  #       initiator_id: "9212094999",
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
      initiator_id: "9212094999",
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


  def update_dmt_transaction
    required = %i[id amount]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    dmt_transaction = Dmt.find_by(id: params[:id])

    if dmt_transaction.nil?
      return render json: { success: false, message: "Transaction not found" }, status: :not_found
    end

    if dmt_transaction.update(amount: params[:amount])
      render json: { success: true, message: "Transaction updated successfully", data: dmt_transaction }, status: :ok
    else
      render json: { success: false, message: dmt_transaction.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end



  def dmt_transaction_verify
    # if params[:otp].blank?
    #   return render json: { success: false, message: "otp is required" }, status: :bad_request
    # end

    required = %i[
    otp recipient_id amount customer_id otp_ref_id
  ]

    missing = required.select { |p| params[p].blank? }
    if missing.any?
      return render json: {
        success: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    hierarchy = current_user.find_hierarchy
    p "======hierarchy==========="
    p hierarchy

    response = EkoDmt::FinoTransferService.call(
      initiator_id: "9212094999",
      user_code: current_user.user_code,
      recipient_id: params[:recipient_id],
      amount: params[:amount],
      customer_id: current_user.phone_number,
      otp: params[:otp],
      otp_ref_id: params[:otp_ref_id],
      latlong: params[:latlong] || "28.6139,77.2090",
      client_ref_id: params[:client_ref_id] || "TXN#{Time.current.to_i}"
    )

    Rails.logger.info "========== EKO OTP VERIFY RESPONSE =========="
    Rails.logger.info response

    eko_reason = response.dig("data", "reason") || response["reason"]
    p "======eko_reason========"
    p eko_reason
    if eko_reason == "OTP Verification failed"
      return render json: {
        success: false,
        message: response[:message] || "OTP Verification failed"
      }, status: :unprocessable_entity
    end

    eko_status = response.dig("data", "status") || response["status"]
    # eko_status = 0
    # ❌ OTP / transfer failed
    if eko_status != 0
      return render json: {
        success: false,
        message: response[:message] || "Amount Grater Than 100"
      }, status: :unprocessable_entity
    end

    amount = params[:amount].to_f

    #======================Dmt===============
    dmt = Dmt.find_by(id: params[:id])
    p "==========dmt"
    dmt.update!(
      status: "Success",
    )
    #======================Dmt===============

    # Verify user PIN
    # unless current_user.set_pin.to_s == params[:pin].to_s
    #   return render json: { success: false, message: "Invalid PIN" }, status: :unauthorized
    # end

    # 🔥 STEP 1: FETCH COMMISSION SLAB
    dmt_surhagre = DmtCommissionSlabRange.find_by(
      "min_amount <= ? AND max_amount >= ?",
      amount, amount
    )

    scheme = Scheme.find(current_user.scheme_id)
    scheme_commission = 100
    commission_eko = dmt_surhagre.surcharge.to_f
    p "==========scheme============="
    p scheme
    Rails.logger.info "=========scheme_commission======= #{scheme_commission}"
    Rails.logger.info "=========commission_eko========= #{commission_eko}"

    # Get commission percentages for each role
    commissions = {}

    # 1. Get retailer commission (current user's scheme)
    p "============params[:scheme_id]========="
    p params[:scheme_id]

    current_user_scheme = current_user.scheme_id
    retailer_commission = DmtCommissionSlab.where(scheme_id: current_user_scheme, to_role: "retailer")
    .pick(:value)
    .to_f

    p "===========retailer_commission=========="
    p retailer_commission

    commissions[:retailer] = retailer_commission

    # 2. Get admin commission (parent user's scheme)
    admin_user = User.find_by(id: current_user.parent_id)
    p "==========admin_user========"
    p admin_user
    admin_scheme_id = admin_user&.scheme_id

    p "=======admin_scheme_id============"
    p admin_scheme_id

    # admin_commission = Commission.joins(:service_product_item)
    # .where(
    #   scheme_id: admin_scheme_id,
    #   to_role: "admin",
    #   service_product_items: { name: params[:operator] }
    # )
    # .pick(:value)
    # .to_f
    admin_commission = DmtCommissionSlab.where(scheme_id: admin_scheme_id, to_role: "admin")
    .pick(:value)
    .to_f

    p "=========admin_commission============"
    p admin_commission

    commissions[:admin] = admin_commission

    # 3. Get master commission
    master_users = User.where(role_id: Role.find_by(title: 'master')&.id)
    master_scheme_id = master_users.first&.scheme_id if master_users.any?

    # master_commission = Commission.joins(:service_product_item)
    # .where(
    #   scheme_id: master_scheme_id,
    #   to_role: "master",
    #   service_product_items: { name: params[:operator] }
    # )
    # .pick(:value)
    # .to_f
    master_commission = DmtCommissionSlab.where(scheme_id: admin_scheme_id, to_role: "master")
    .pick(:value)
    .to_f

    commissions[:master] = master_commission

    # 4. Get dealer commission
    dealer_users = User.where(role_id: Role.find_by(title: 'dealer')&.id)
    dealer_scheme_id = dealer_users.first&.scheme_id if dealer_users.any?

    # dealer_commission = Commission.joins(:service_product_item)
    # .where(
    #   scheme_id: dealer_scheme_id,
    #   to_role: "dealer",
    #   service_product_items: { name: params[:operator] }
    # )
    # .pick(:value)
    # .to_f
    dealer_commission = DmtCommissionSlab.where(scheme_id: admin_scheme_id, to_role: "master")
    .pick(:value)
    .to_f

    commissions[:dealer] = dealer_commission

    Rails.logger.info "Commissions by role: #{commissions}"

    # Calculate commission amounts for each role using hierarchy chain
    commission_map = {}

    # Start from top (Superadmin)
    # Superadmin gets: scheme_commission - admin_commission
    remaining_percent = scheme_commission - admin_commission
    remaining_percent = 0 if remaining_percent.negative?
    commission_map[:superadmin] = (remaining_percent / 100) * commission_eko

    # Move down the chain - Admin
    # Find the highest commission among roles below admin
    next_highest_below_admin = [master_commission, dealer_commission, retailer_commission].max

    # Admin gets: admin_commission - next_highest_below_admin
    admin_diff = admin_commission - next_highest_below_admin
    admin_diff = 0 if admin_diff.negative?
    commission_map[:admin] = (admin_diff / 100) * commission_eko

    # Move down - Master
    # Find the highest commission among roles below master
    next_highest_below_master = [dealer_commission, retailer_commission].max

    # Master gets: master_commission - next_highest_below_master
    master_diff = master_commission - next_highest_below_master
    master_diff = 0 if master_diff.negative?
    commission_map[:master] = (master_diff / 100) * commission_eko

    # Move down - Dealer
    # Dealer gets: dealer_commission - retailer_commission
    dealer_diff = dealer_commission - retailer_commission
    dealer_diff = 0 if dealer_diff.negative?
    commission_map[:dealer] = (dealer_diff / 100) * commission_eko

    # Retailer gets their own commission percentage
    commission_map[:retailer] = (retailer_commission / 100) * commission_eko

    Rails.logger.info "Commission Breakdown: #{commission_map}"

    # Verify total commission doesn't exceed EKO commission
    total_commission = commission_map.values.sum
    if total_commission > commission_eko
      Rails.logger.error "Commission overflow! Total: #{total_commission}, EKO: #{commission_eko}"
      # Adjust retailer commission to fit within limit
      excess = total_commission - commission_eko
      commission_map[:retailer] = [commission_map[:retailer] - excess, 0].max
      Rails.logger.info "Adjusted Commission Breakdown: #{commission_map}"
    end


    # 🔥 STEP 2: Commission Distridubte


    wallet = Wallet.find_by(user_id: current_user.id)
    unless wallet
      return render json: { success: false, message: "Wallet not found" }, status: :not_found
    end

    p "============== walletamout"
    p wallet.balance.to_f

    p "=================== params[:amount]"
    p params[:amount]

    # Check sufficient balance
    if wallet.balance.to_f < params[:amount].to_f
      return render json: { success: false, message: "Insufficient wallet balance" }, status: :unprocessable_entity
    end

    # Perform transaction safely
    dmt_transaction = nil   # 👈 ADD THIS LINE

    ActiveRecord::Base.transaction do
      wallet.lock!

      if wallet.balance.to_f < params[:amount].to_f
        raise ActiveRecord::Rollback, "Insufficient wallet balance after lock"
      end

      main_maount = params[:amount].to_f + dmt_surhagre.surcharge + dmt_surhagre.tds_percent + dmt_surhagre.gst_percent
      wallet.update!(balance: wallet.balance.to_f - main_maount)
      dmt.update(amount: main_maount, transaction_status: true)

      txn_id = "TXN#{rand(100000..999999)}"

      dmt_transaction = DmtTransaction.create!(
        dmt_id: dmt.id,
        user_id: current_user.id,
        txn_id: txn_id,
        sender_mobile_number: params[:sender_mobile_number],
        bank_name: params[:bank_name],
        account_number: params[:account_number],
        amount: amount,
        status: "success",
        fee: response.dig("data", "fee"),
        tid: response.dig("data", "tid"),
        tds: response.dig("data", "tds"),
        service_tax: response.dig("data", "service_tax"),
        commission: response.dig("data", "commission"),
        txstatus_desc: response.dig("data", "txstatus_desc"),
        collectable_amount: response.dig("data", "collectable_amount")
      )
    end


    render json: {
      code: "200",
      success: true,
      message: "PIN verified successfully. Transaction marked as success.",
      data: {
        transaction: dmt_transaction,
        bank_name: dmt_transaction.bank_name,
        remaining_balance: wallet.balance
      }
    }, status: :ok

    # === Distribute Commission ==
    # === Add current_user into distribution as well ===
    ([current_user] + hierarchy).each do |user|
      role = user.role.title.downcase.to_sym

      Rails.logger.info "=========role============="
      Rails.logger.info role.inspect

      next unless commission_map[role]

      commission_amount = commission_map[role]
      Rails.logger.info "===============commission_amount"
      Rails.logger.info commission_amount.inspect

      next if commission_amount <= 0

      user_wallet = Wallet.find_by(user_id: user.id)
      next unless user_wallet

      user_wallet.update!(balance: user_wallet.balance + commission_amount)

      DmtCommission.create!(
        dmt_id: dmt.id,
        user_id: user.id,
        commission_amount: commission_amount,
        role: role,
      )

      Rails.logger.info "[Commission] #{role.upcase} (User #{user.id}) credited ₹#{commission_amount.round(2)}"
    end

    # === Distribute Commission ===

  rescue ActiveRecord::RecordInvalid => e
    render json: { success: false, message: "Transaction failed: #{e.message}" }, status: :unprocessable_entity
  end



end
