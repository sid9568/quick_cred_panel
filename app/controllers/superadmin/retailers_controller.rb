class Superadmin::RetailersController < Superadmin::BaseController
  before_action :set_retailer, only: [ :show, :edit, :update, :destroy ]

  def index
    @retailers = User.joins(:role).where(roles: { title: [ "retailer", "master", "dealer" ] }).order(created_at: :desc)

    # 🔍 Unified Search (name + email + mobile)
    if params[:search].present?
      q = "%#{params[:search].downcase}%"

      @retailers = @retailers.where(
        "LOWER(CONCAT_WS(' ', first_name, last_name)) LIKE :q
     OR LOWER(email) LIKE :q
     OR phone_number LIKE :q",
        q: q
      )
    end


    # 🟢 Status filter
    if params[:status].present?
      @retailers = @retailers.where(status: params[:status] == "active")
    end

    # 📅 Date range
    if params[:start_date].present?
      @retailers = @retailers.where("created_at >= ?", params[:start_date].to_date.beginning_of_day)
    end

    if params[:end_date].present?
      @retailers = @retailers.where("created_at <= ?", params[:end_date].to_date.end_of_day)
    end

    @retailers = @retailers.order(created_at: :desc)
  end


  def index
    @retailers = User.joins(:role).where(roles: { title: [ "retailer", "master", "dealer" ] }).order(created_at: :desc)

    # 🔍 Full Name filter
    if params[:full_name].present?
      search = params[:full_name].downcase
      @retailers = @retailers.where(
        "LOWER(first_name || ' ' || last_name) LIKE ?", "%#{search}%"
      )
    end

    # 📞 Mobile filter
    if params[:phone_number].present?
      @retailers = @retailers.where("phone_number LIKE ?", "%#{params[:phone_number]}%")
    end

    # 📧 Email filter
    if params[:email].present?
      @retailers = @retailers.where("email LIKE ?", "%#{params[:email]}%")
    end

    # 🟢 Status filter
    if params[:status].present?
      @retailers = @retailers.where(status: params[:status] == "active")
    end

    # 📅 Date Range filter
    if params[:start_date].present?
      @retailers = @retailers.where("created_at >= ?", params[:start_date].to_date.beginning_of_day)
    end

    if params[:end_date].present?
      @retailers = @retailers.where("created_at <= ?", params[:end_date].to_date.end_of_day)
    end

    @retailers = @retailers.order(created_at: :desc)
  end


  def show
  end

  def new
    @retailer = User.new
  end

  def create
    role_id = params[:user][:role_id]
    p "==========="
    p role_id
    @retailer = User.new(retailer_params.merge(role_id: role_id))

    if @retailer.save
      redirect_to superadmin_retailers_path, notice: "Retailer created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end


   def edit
    @retailer = User.find(params[:id])
    p "============scheme_id="
    @retailer.scheme_id
  end

  def update
    @retailer = User.find(params[:id])
    p "============scheme_id="
    @retailer.scheme_id
    if @retailer.update(retailer_params)

      # ==============================
      # 1️⃣ UPDATE SCHEME FOR CHILD USERS
      # ==============================
      if params[:scheme_id].present?
        old_scheme_id = current_user.scheme_id
        new_scheme_id = params[:scheme_id]

        child_users = @retailer
                        .all_descendants
                        .where(scheme_id: old_scheme_id)

        child_users.update_all(scheme_id: new_scheme_id)
      end

      # ==============================
      # 2️⃣ UPDATE SERVICES
      # ==============================
      service_ids = Array(params[:user][:service_ids]).map(&:to_i)
      assigner = User.find(136) # better: current_admin_user

      existing_ids = @retailer.user_services.pluck(:service_id)

      # Remove unchecked services
      (existing_ids - service_ids).each do |sid|
        UserService.where(
          assigner: assigner,
          assignee: @retailer,
          service_id: sid
        ).destroy_all
      end

      # Add new services
      (service_ids - existing_ids).each do |sid|
        UserService.create!(
          assigner: assigner,
          assignee: @retailer,
          service_id: sid
        )
      end

      redirect_to superadmin_admins_path,
        notice: "Admin updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def update_status
    @retailer = User.find(params[:id])
    @enquiry = Enquiry.find_by(email: @retailer.email)
    if @enquiry.present?
      @enquiry.update!(status: true)
    end
    @retailer.update!(status: !@retailer.status)

    # Send mail only if the account is active now
    if @retailer.status
      Thread.new do
        begin
          UserMailer.status_updated(@retailer).deliver_now
        rescue => e
          Rails.logger.error "Mailer thread error: #{e.message}"
        end
      end
    end


    redirect_to superadmin_retailers_path, notice: "Retailer status updated successfully."
  end



  def destroy
    @retailer.destroy
    redirect_to superadmin_retailers_path, notice: "Retailer deleted successfully."
  end

  def export
    @retailers = User.all

    respond_to do |format|
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=\"retailers-#{Date.today}.csv\""
        headers["Content-Type"] ||= "text/csv"
      end
    end
  end

  private

  def set_retailer
    @retailer = User.find(params[:id])
  end

  def retailer_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :phone_number,
                                 :password,
                                 :otp,
                                 :verify_otp,
                                 :otp_expires_at,
                                 :country_code,
                                 :alternative_number,
                                 :aadhaar_number,
                                 :pan_card,
                                 :date_of_birth,
                                 :gender,
                                 :business_name,
                                 :business_owner_type,
                                 :business_nature_type,
                                 :business_registration_number,
                                 :gst_number,
                                 :pan_number,
                                 :address,
                                 :city,
                                 :state,
                                 :pincode,
                                 :landmark,
                                 :username,
                                 :scheme,
                                 :referred_by,
                                 :bank_name,
                                 :account_number,
                                 :ifsc_code,
                                 :account_holder_name,
                                 :notes,
                                 :session_token,)
  end
end
