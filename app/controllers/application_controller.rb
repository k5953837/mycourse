class ApplicationController < ActionController::Base
  protected

  def authenticate_admin
    redirect_to root_path, alert: 'Not authorized.' unless current_user.admin?
  end
end
