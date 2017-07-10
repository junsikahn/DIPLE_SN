class Users::FavoredSubjectsController < Users::ProfilesController
  def edit
    return unless current_user.favored_subjects.blank?
    3.times do
      current_user.favored_subjects.build
    end
  end

  def update
    return if current_user.update(favored_subject_params)
    render :edit
  end

  protected

  def favored_subject_params
    params
      .fetch(:user, {})
      .permit(favored_subjects_attributes: [:id, :user_id, :subject_id, :_destroy])
  end
end
