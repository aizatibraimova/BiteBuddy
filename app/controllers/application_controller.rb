class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_forgery_protection
  before_action :set_children

  private

  def set_children
    @children = current_user ? current_user.children : []
  end
end
