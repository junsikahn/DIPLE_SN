class Users::CareersController < Users::ProfilesController
  def edit
    return unless current_user.careers.blank?
    current_user.univ_careers.build if current_user.mentor?
    current_user.high_careers.build
  end

  def update
    return if current_user.update(career_params)
    render :edit
  end

  def preview
    results =
      case params[:category]
      when 'univ'   then Standard::University.where('name LIKE ?', "%#{params[:q]}%")
      when 'high'   then Standard::Highschool.where('name LIKE ?', "%#{params[:q]}%")
      when 'major'  then Standard::Major.where('name LIKE ?', "%#{params[:q]}%")
      end
    render json: { results: results.as_json }
  end

  protected

  def career_params
    params
      .fetch(:user, {})
      .permit(univ_careers_attributes: [:id, :user_id, :category, :school, :major_1, :major_2, :major_3, :entrance_year, :graduate_year, :status, :_destroy],
              high_careers_attributes: [:id, :user_id, :category, :school, :entrance_year, :graduate_year, :status, :_destroy])
  end
end
