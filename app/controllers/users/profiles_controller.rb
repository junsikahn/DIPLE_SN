class Users::ProfilesController < ApplicationController
  before_action :redirect_if_role_unselected
  before_action :reject_update_while_recruiting, only: [:edit, :update]

  def show
    respond_to do |format|
      format.html do
        redirect_to edit_users_profile_path and return if !current_user.recognized?
      end
      format.js
    end
  end

  # GET /users/profile/edit
  def edit
    respond_to do |format|
      format.html do
        redirect_to users_profile_path and return if current_user.recognized?
      end
      format.js
    end
  end

  # PATCH /users/profile
  def update
    respond_to do |format|
      format.html do
        redirect_to users_profile_path and return if current_user.update(profile_params)
        render :edit
      end
      format.js do
        return if current_user.update(profile_params)
        render :edit
      end
    end
  end

  private

  def redirect_if_role_unselected
    return if current_user.mentor? || current_user.mentee?
    flash[:error] = '롤을 먼저 선택해주세용'
    redirect_to users_role_path
  end

  def reject_update_while_recruiting
    respond_to do |format|
      format.html
      format.js do
        render :cannot_update if current_user.mentor? && current_user.mentor.recruited_at?
      end
    end
  end

  protected

  def profile_params
    params
      .fetch(:user, {})
      .permit(:name, :gender, :birthday)
  end
end
