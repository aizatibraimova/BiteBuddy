class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_children
  skip_forgery_protection

  private

  def set_children
    @children = current_user ? current_user.children : []
  end
end
