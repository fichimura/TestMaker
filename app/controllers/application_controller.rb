class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery

  after_action :user_activity

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized  

  include PublicActivity::StoreController #save current_user using gem public_activity

  include Pagy::Backend

  
  before_action :set_global_variables, if: :user_signed_in?
  def set_global_variables
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
  end

  def can_administer?
    true
  end



  private

  def user_activity
    current_user.try :touch
  end

  def user_not_authorized #pundit
    flash[:alert] = "Você não possui autorização para esta ação."
    redirect_to(request.referrer || root_path)
  end
end
