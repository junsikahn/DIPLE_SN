class App::HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :redirect_if_unverified

  # GET /
  def index
  end
end
