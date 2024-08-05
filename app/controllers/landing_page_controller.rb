class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if user_signed_in?
      @children = current_user.children
    end
  end
end
