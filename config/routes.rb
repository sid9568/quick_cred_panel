Rails.application.routes.draw do

  namespace :dealer do
    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "dashboards/index"
  end

  namespace :master do
    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "dashboards/index"
    get "users/index"
  end

  namespace :admin do
    get "accounts/index"
    get "accounts/new"
    post "accounts/add_credit"
    get "accounts/debit_index"
    post "accounts/add_debit"

    get "reports/index"
    get "reports/report_filter"

    get "payments/index"
    post "payments/approved"
    get "payments/verify_pin"

    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "dashboards/index"
    get "scheme/index"

    # get "user_services/index"
    # get "user_services/new"
    get "user_services/view_blance"
    get "user_services/set_pin"
    post "user_services/set_pin_update"

    resources :user_services

    get "collect_moneys/index"
    get "collect_moneys/new"
    post "collect_moneys/create"


    get "recharges_and_bills/index"
    get "recharges_and_bills/transaction"
    post "recharges_and_bills/amdmin_commission_set"


    post "user_services/create", to: "user_services#create", as: :user_services_create
    # resources :user_services
  end

  namespace :api do
    namespace :v1 do
      namespace :auth do

        # LOGIN (Admin / Master / Dealer / Agent)
        post "login", to: "sessions#login"

        # VERIFY OTP
        post "verify_email", to: "sessions#verify_email"

        # CREATE USER (Retailer / Agent / Dealer)
        post "register", to: "sessions#create"

        # ROLE LIST
        get "roles", to: "sessions#role"

        post "resend_otp", to: "sessions#resend_otp"

      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :admin do
        get "dashboards/index"

        get  "accounts/credit_logs", to: "accounts#credit_logs"
        post "accounts/add_credit",  to: "accounts#add_credit"

        get  "accounts/debit_logs",  to: "accounts#debit_logs"
        post "accounts/add_debit",   to: "accounts#add_debit"

        resources :user_services do

          member do
            put :update_status
          end
          collection do
            get :service_list
            get :scheme_list
            get :role_list
            post :master_role
            post :dealer_role
            get :scheme_role
          end
        end

        resources :schemes
        resources :banks
        resources :wallets, only: [:index, :create] do
          collection do
            get :bank
            get :bank_details
            get :wallet_history
            get :balance
            get :virtual_balance
          end
        end

        resources :admin_profiles do
          collection do
            post "set_pin"
            post "reset_transaction_pin"
            post "forget_transaction_pin"
            post "verfiy_transaction_pin"

            post "set_password"
            post "forgot_password"
            post "verify_password_otp"
            post "forget_password"
            post "main_forget_password"
            post "set_mpin"
          end
        end

        resources :commissions do
          collection do
            post "commission_operator"
            post "show_commission"
            get "scheme_list"
            post "set_commission"
            post "service_category"
            post "service_product"
          end
        end

        resources :dmts do
          collection do
            get "scheme_list"
            post "dmt_commissions"
            post "commission_list"
            post "show_dmt_commission"
          end
        end

        resources :payments do
          collection do
            post "index"
            post "approved"
            post "reject_payment_request"
          end
        end

        post "reports/index"
        # resources :reports , only: [:index]

        resources :support_tickets, only: [:create, :index, :show] do
          patch :update_status, on: :member
        end

        # resources :refunds, only: [:index, :refund_transaction]

        resources :refunds, only: [:index, :create] do
          post :refund_transaction, on: :member
        end

      end
    end
  end




  namespace :api do
    namespace :v1 do
      namespace :customer do
        post "kycs/user_details"
        post "kycs/aadhaar_otp", to: "kycs#aadhaar_otp"
        post "kycs/verify_aadhaar_otp", to: "kycs#verify_aadhaar_otp"
        post "kycs/manual_aadhaar_upload", to: "kycs#manual_aadhaar_upload"
        post "kycs/pencard_otp", to: "kycs#pencard_otp"
        post "kycs/verify_pencard_otp", to: "kycs#verify_pencard_otp"
        post "kycs/selfie", to: "kycs#selfie"
        get "kycs/kyc_details", to: "kycs#kyc_details"
        post "kycs/submit_kyc_details", to: "kycs#submit_kyc_details"

        get "locations/index"

        post "sessions/login"
        post "sessions/verify_otp"
      end

      namespace :master do
        get "dashboards/index"
      end

      namespace :agent do
        get "dashboards/index"
        post "sessions/login"
        post "sessions/create"
        get "sessions/role"
        post "sessions/verify_email"
        post "enquires/create"
        get "enquires/role"

        get "user_services/index"
        post "user_services/service_category"
        post "user_services/service_product"
        get "user_services/earn_commission"
        post "user_services/transaction_list"

        post "recharges/recharge"
        post "recharges/recharge_list"
        post "recharges/verify_pin"
        post "fetch_eko_operators", to: "recharges#fetch_eko_operators"
        get "fetch_eko_locations", to: "recharges#fetch_eko_locations"
        post "fetch_eko_plans", to: "recharges#fetch_eko_plans"
        post "eko_mobile_recharge", to: "recharges#eko_mobile_recharge"
        get "activate_eko_service", to: "recharges#activate_eko_service"
        post "activate_eko_service_ar", to: "recharges#activate_eko_service_ar"
        post "activate_bbps_service", to: "recharges#activate_bbps_service"
        post "create", to: "recharges#create"
        post "paybill", to: "recharges#paybill"
        post "fetch_bill", to: "recharges#fetch_bill"

        post "fetch_plans", to: "recharges#fetch_plans"
        post "recharges/fetch_eko_user_info"

        get "wallets/balance"
        post "wallets/create"
        post "wallets/bank_list"
        post "wallets/fund_request_list"
        get "wallets/bank_list"
        post "wallets/bank_details"
        get "wallets/wallet_history"
        get "wallets/agent_bank"

        post "filters/category_filter"
        post "filters/service_category_filter"
        post "filters/service_product"

        post "commission_reports/index"

        get "dmts/dmt_transactions_list"
        post "dmts/sender_details"
        post "dmts/verify_eko_otp"
        post "dmts/dmt_transactions"
        post "dmts/dmt_transaction_verify"
        post "dmts/update_dmt_transaction"
        post "dmts/benfisries_dmt_transaction"
        post "dmts/beneficiary_fetch"
        post "dmts/beneficiary_list"
        post "dmts/user_onboard"
        post "dmts/check_profile"
        post "dmts/create_customer"
        post "dmts/verify_otp"
        get "dmts/bank_list"
        post "dmts/send_ekodmt_otp"
        post "dmts/bank_verify"
        post "biometric_ekyc_otp_verify", to: "dmts#biometric_ekyc_otp_verify"
        post "biometric", to: "dmts#biometric"
        post "biometric_kyc", to: "dmts#biometric_kyc"


        resources :beneficiaries do
          collection do
            post "send_otp"
            post "verify_otp"
          end
        end

        resources :support_tickets, only: [:create, :index, :show] do
          patch :update_status, on: :member
        end

        # resources :refunds, only: [:index, :create]

        resources :refunds, only: [:index, :create] do
          post :refund_transaction, on: :collection
          post :refund_verify_otp, on: :collection
        end


        resources :reatailer_profiles, only: [:index]
        get "reatailer_profiles/user_profile"
        post "reatailer_profiles/set_pin"
        post "reatailer_profiles/reset_password"
        post "reatailer_profiles/forgot_password"
        post "reatailer_profiles/verify_password_otp"
        post "reatailer_profiles/forget_password"
        post "reatailer_profiles/main_forget_password"

      end

    end
  end


  root "superadmin/dashboards#index"

  namespace :superadmin do
    get "sessions/login"
    post "sessions/create"
    delete "sessions/destroy"
    get "sessions/forgot_page"
    post "sessions/forgot_email"
    get "sessions/opt_page"
    post "sessions/verify_otp"
    get "sessions/set_password"
    post "sessions/set_password"
    get "sessions/otp"
    post "sessions/verify_otp_login"

    get "financial_services/index"
    get "customer/index"
    post "customer/verify_status"

    get "reports/index"
    get "reports/report_filter"

    get "commissions/index"
    get "commissions/commission_filter"
    post "commissions/set_commission"
    get "commissions/new"
    get "commissions/service_list"
    resources :commissions

    get "dmt_commissions/index"
    get "dmt_commissions/new"
    resources :dmt_commissions

    get "accounts/index"
    get "accounts/new"
    post "accounts/add_credit"
    get "accounts/debit_index"
    post "accounts/add_debit"

    post "payments/approved"
    get "payments/index"
    get "payments/set_pin"
    post "payments/set_pin_update"
    get "payments/forgot_mpin"
    post "payments/send_mpin_otp"
    get "payments/verify_mpin"
    post "payments/verify_mpin_otp"
    get "payments/set_pin_agin"
    post "payments/set_pin_agin_update"
    post "payments/reject_payment_request"

    get "reset_passwords/reset_page"
    post "reset_passwords/reset_password"
    post "reset_passwords/forget_password"
    post "reset_passwords/main_forget_password"

    get "blance/index"
    get "categories/index"
    get "recharge_and_bill/index"
    get "recharge_and_bill/bbps_commission"
    get "recharge_and_bill/transaction"
    get "recharge_and_bill/view"
    post "recharge_and_bill/commission_set"

    get "retailers/export"

    get "service/index"
    get "enqueries/index"


    get "scheme/index"
    post "scheme/create", to: "scheme#create", as: :scheme_create
    post "scheme/update", to: "scheme#update", as: :scheme_update

    resources :scheme, only: [:destroy]

    post "admins/create", to: "admins#create", as: :admins_create
    post "admins/:id/admin_update_stauts", to: "admins#admin_update_stauts", as: :admin_update_status

    get  "travel_and_stay_report/travel_report"

    resources :admins
    resources :banks
    resources :services
    resources :categories
    resources :service_products do
      member do
        get :view_product_item
        get :new_prodcut_item
        post :prodcut_item_create
        get :prodcut_item_edit
        post :prodcut_item_update
        delete :prodcut_item_destroy
      end
    end


    namespace :dealer do
      get "dashboards/index"
    end

    namespace :master do
      get "dashboards/index"
    end



    get "dashboards/index"
    resources :retailers
    post "retailers/create", to: "retailers#create", as: :retailer_create
    post "retailers/:id/update_status", to: "retailers#update_status", as: :retailer_update_status
    resources :roles
  end


  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
