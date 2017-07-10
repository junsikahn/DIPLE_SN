class AdminController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_admin!
  before_action :default_paginate!, only: :index

  semantic_breadcrumb 'Home', :admin_root_path

  private

  def authenticate_admin!
    return if user_signed_in? && ![1,2].index(current_user.id).nil?
    redirect_to root_path
  end

  def default_paginate!
    params[:page] = 1 if params[:page].nil?
    params[:per] = 10 if params[:per].nil?
  end
end
