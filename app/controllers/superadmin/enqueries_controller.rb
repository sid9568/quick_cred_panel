class Superadmin::EnqueriesController < ApplicationController

  def index
    @enquires = Enquiry.all.order(created_at: :desc)
  end
end
