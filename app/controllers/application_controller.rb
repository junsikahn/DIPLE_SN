class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :authenticate_user!
  before_action :default_paginate!, only: :index

  private

  def default_paginate!
    params[:page] = params[:page] || 1
    params[:per] = params[:per] || 10
  end
end
