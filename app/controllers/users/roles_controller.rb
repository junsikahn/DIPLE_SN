class Users::RolesController < ApplicationController
  before_action :redirect_if_role_selected, except: :destroy

  # GET /users/role
  def show
  end

  # POST /users/role
  def create
    if params[:selection] == 'mentor'
      Mentor.create(user_id: current_user.id)
    elsif params[:selection] == 'mentee'
      Mentee.create(user_id: current_user.id)
    end
    flash[:alert] = '매칭을 위해 프로필을 입력해주세요'
    redirect_to edit_users_profile_path
  end

  # DELETE /users/role
  def destroy
    if current_user.mentor?
      Mentor.find_by_user_id(current_user.id).destroy
    elsif current_user.mentee?
      Mentee.find_by_user_id(current_user.id).destroy
    end
    flash[:alert] = '유저 롤을 선택해주세요'
    redirect_to users_role_path
  end

  private

  def redirect_if_role_selected
    return if !current_user.mentor? && !current_user.mentee?
    redirect_to edit_users_profile_path
  end
end
