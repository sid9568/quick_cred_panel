require "rails_helper"

RSpec.describe "Api::V1::Agent::Aeps::Fingpay::Transactions#create", type: :request do
  # Real payloads captured from the EKO/Fingpay AEPS API, pasted as-is so the
  # spec exercises the exact shape the controller has to deal with in production.
  SUCCESS_API_RESPONSE = {
    "data" => {
      "fee" => "", "tds" => "0.0", "tid" => "3570484136", "bank" => "State Bank of India",
      "shop" => "DGLYF INNOVATION PRIVATE LIMITED", "stan" => "", "aadhar" => "XXXX XXXX 2113",
      "amount" => "100.0", "reason" => "", "balance" => "1106.7", "comment" => "Request Completed",
      "totalfee" => "0.0", "auth_code" => "", "tx_status" => "0", "user_code" => "38130026",
      "commission" => "0.0", "sender_name" => "SiddharthGautam", "service_tax" => "0.0", "terminal_id" => "",
      "bank_ref_num" => "620516417524", "merchantname" => "Siddharth gautam", "merchant_code" => "",
      "customer_balance" => "0.0", "transaction_date" => "24-07-26 16:28:57", "transaction_time" => "24-07-26 16:28:57",
      "shop_address_line1" => "Jay SIngh Pura, 04, Vrindavan Rd, near Methodist Hospital, Masani, Mathura,, Uttar Pradesh, Mathura,-281001"
    },
    "status" => 0,
    "message" => "Transaction Successful",
    "response_type_id" => 1463,
    "response_status_id" => 0
  }.freeze

  FAIL_API_RESPONSE = {
    "data" => {
      "tid" => "3570476356", "shop" => "DGLYF INNOVATION PRIVATE LIMITED", "stan" => "", "aadhar" => "XXXX XXXX 3098",
      "amount" => "100.0", "reason" => "", "comment" => "Invalid Transaction", "auth_code" => "", "tx_status" => "1",
      "user_code" => "38130026", "sender_name" => "SiddharthGautam", "terminal_id" => "", "bank_ref_num" => "620515262452",
      "merchantname" => "Siddharth gautam", "merchant_code" => "", "customer_balance" => "0.00",
      "transaction_date" => "24-07-26 15:29:08", "transaction_time" => "24-07-26 15:29:08",
      "shop_address_line1" => "Jay SIngh Pura, 04, Vrindavan Rd, near Methodist Hospital, Masani, Mathura,, Uttar Pradesh, Mathura,-281001"
    },
    "status" => 1464,
    "message" => "Transaction Fail",
    "response_type_id" => 1464,
    "response_status_id" => 1
  }.freeze

  let(:scheme) { create(:scheme) }

  let(:superadmin_role) { create(:role, :superadmin) }
  let(:admin_role)      { create(:role, :admin) }
  let(:dealer_role)     { create(:role, :dealer) }
  let(:retailer_role)   { create(:role, :retailer) }

  let(:superadmin) { create(:user, role: superadmin_role) }
  let(:admin)      { create(:user, role: admin_role, parent: superadmin) }
  let(:dealer)     { create(:user, role: dealer_role, parent: admin) }
  let(:retailer)   { create(:user, role: retailer_role, parent: dealer, scheme_id: scheme.id) }

  let(:current_user) { retailer }

  let!(:superadmin_wallet) { create(:wallet, user: superadmin, balance: 0) }
  let!(:admin_wallet)      { create(:wallet, user: admin, balance: 0) }
  let!(:dealer_wallet)     { create(:wallet, user: dealer, balance: 0) }
  let!(:retailer_wallet)   { create(:wallet, user: retailer, balance: 0) }
  let!(:aeps_wallet)       { create(:aeps_wallet, user: retailer, balance: 0) }

  let(:token) { JsonWebToken.encode(user_id: current_user.id) }
  let(:auth_headers) { { "Authorization" => "Bearer #{token}" } }

  let(:valid_params) do
    {
      bank_code: "SBIN0001234",
      amount: "100",
      piddata: "<PidData>fake</PidData>",
      phone_number: "9999999999",
      aadhar: "999999992113"
    }
  end

  def json
    JSON.parse(response.body)
  end

  before do
    # api_balance before_action calls out to EKO for the header wallet balance;
    # stub it so specs don't depend on / hit the real network.
    allow_any_instance_of(Eko::WalletService).to receive(:get_wallet_balance).and_return({})
  end

  describe "POST create" do
    context "when required params are missing" do
      it "returns 422 and does not call the provider" do
        expect(Aeps::Fingpay::TransactionService).not_to receive(:new)

        post api_v1_agent_aeps_fingpay_transactions_path,
             params: valid_params.except(:amount),
             headers: auth_headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["success"]).to eq(false)
        expect(json["error"]).to include("amount")
      end
    end

    context "when the provider call fails at the transport/HTTP level" do
      before do
        allow_any_instance_of(Aeps::Fingpay::TransactionService).to receive(:call)
          .and_return(success: false, error: "connection reset")
      end

      it "returns 422 and does not touch any wallet" do
        post api_v1_agent_aeps_fingpay_transactions_path,
             params: valid_params,
             headers: auth_headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["success"]).to eq(false)
        expect(aeps_wallet.reload.balance.to_f).to eq(0.0)
        expect(AepsTransaction.count).to eq(0)
      end
    end

    context "when EKO reports a genuinely successful cash withdrawal (response_status_id: 0, tx_status: 0)" do
      before do
        allow_any_instance_of(Aeps::Fingpay::TransactionService).to receive(:call)
          .and_return(success: true, status: 200, data: SUCCESS_API_RESPONSE)

        create(:aeps_commission_slab_range,
               scheme: scheme, min_amount: 0, max_amount: 100_000, value: 2.0, active: true)
      end

      let!(:slab_range) { AepsCommissionSlabRange.where(scheme: scheme, service_type: "transaction").first }

      before do
        create(:aeps_commission_slab, scheme_id: scheme.id, aeps_commission_slab_range_id: slab_range.id,
                                       to_role: "retailer", value: 1.0)
        create(:aeps_commission_slab, scheme_id: scheme.id, aeps_commission_slab_range_id: slab_range.id,
                                       to_role: "dealer", value: 0.5)
        create(:aeps_commission_slab, scheme_id: scheme.id, aeps_commission_slab_range_id: slab_range.id,
                                       to_role: "master", value: 0.3)
      end

      it "returns success and credits the AEPS wallet by the transaction amount" do
        post api_v1_agent_aeps_fingpay_transactions_path,
             params: valid_params,
             headers: auth_headers

        expect(response).to have_http_status(:ok)
        expect(json["success"]).to eq(true)
        expect(aeps_wallet.reload.balance.to_f).to eq(100.0)
      end

      it "persists the AepsTransaction with the provider's tx_status" do
        post api_v1_agent_aeps_fingpay_transactions_path,
             params: valid_params,
             headers: auth_headers

        txn = AepsTransaction.order(:created_at).last
        expect(txn).not_to be_nil
        expect(txn.tx_status).to eq("0")
        expect(txn.status).to eq("success")
        expect(txn.opening_balance.to_f).to eq(0.0)
        expect(txn.closing_balance.to_f).to eq(100.0)
      end

      it "distributes commission up the hierarchy per the configured slabs" do
        post api_v1_agent_aeps_fingpay_transactions_path,
             params: valid_params,
             headers: auth_headers

        expect(retailer_wallet.reload.balance.to_f).to eq(1.0)
        expect(dealer_wallet.reload.balance.to_f).to eq(0.5)
        expect(admin_wallet.reload.balance.to_f).to eq(0.2)
        expect(superadmin_wallet.reload.balance.to_f).to eq(0.0)
      end
    end

    context "when EKO reports a failed cash withdrawal (response_status_id: 1, tx_status: 1)" do
      before do
        allow_any_instance_of(Aeps::Fingpay::TransactionService).to receive(:call)
          .and_return(success: true, status: 200, data: FAIL_API_RESPONSE)

        slab_range = create(:aeps_commission_slab_range,
                             scheme: scheme, min_amount: 0, max_amount: 100_000, value: 2.0, active: true)
        create(:aeps_commission_slab, scheme_id: scheme.id, aeps_commission_slab_range_id: slab_range.id,
                                       to_role: "retailer", value: 1.0)
      end

      it "does not credit the AEPS wallet or distribute any commission" do
        post api_v1_agent_aeps_fingpay_transactions_path,
             params: valid_params,
             headers: auth_headers

        expect(aeps_wallet.reload.balance.to_f).to eq(0.0)
        expect(retailer_wallet.reload.balance.to_f).to eq(0.0)
      end

      it "reports the transaction as failed, not as success" do
        post api_v1_agent_aeps_fingpay_transactions_path,
             params: valid_params,
             headers: auth_headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["success"]).to eq(false)
      end
    end

    context "when something raises unexpectedly" do
      before do
        allow_any_instance_of(Aeps::Fingpay::TransactionService).to receive(:call)
          .and_raise(StandardError, "boom")
      end

      it "returns 500 with the error message" do
        post api_v1_agent_aeps_fingpay_transactions_path,
             params: valid_params,
             headers: auth_headers

        expect(response).to have_http_status(:internal_server_error)
        expect(json["success"]).to eq(false)
        expect(json["error"]).to eq("boom")
      end
    end
  end
end
