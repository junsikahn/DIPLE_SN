class Users::AvatarsController < Users::ProfilesController
  def edit
  end

  def update
    return if current_user.update(avatar_params)
    render :edit
  end

  protected

  def avatar_params
    params
      .fetch(:user, {})
      .permit(:avatar)
  end
end
