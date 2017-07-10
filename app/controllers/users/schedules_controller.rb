class Users::SchedulesController < Users::ProfilesController
  def edit
  end

  def update
    return if current_user.update(schedule_params)
    render :edit
  end

  private

  def schedule_params
    params
      .fetch(:user, {})
      .permit(schedules_attributes: [:id, :user_id, :day_of_week, :time_start, :time_end, :_destroy])
  end
end
