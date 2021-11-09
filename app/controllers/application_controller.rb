class ApplicationController < ActionController::Base
  protected

  def authenticate_admin
    redirect_to '/', alert: 'Not authorized.' unless current_user.admin?
  end
end
