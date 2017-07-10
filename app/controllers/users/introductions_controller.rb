class Users::IntroductionsController < Users::ProfilesController
  def edit
  end

  def update
    return if current_user.mentor.update(mentor_params)
    render :edit
  end

  protected

  def mentor_params
    params
      .fetch(:mentor, {})
      .permit(:self_introduction)
  end
end
