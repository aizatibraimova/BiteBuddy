class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_children
  skip_forgery_protection

  include Pundit

  # Rescue from Pundit errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_children
    @children = current_user ? current_user.children : []
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
