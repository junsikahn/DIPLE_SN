class App::DashboardsController < ApplicationController
  before_action :set_date_params, only: :show

  def index
    if current_user.mentor?
      @matches = Match.includes(:mentor, :mentor_users, :mentee, :mentee_users, :schedules).where(mentor_id: current_user.mentor.id)
    elsif current_user.mentee?
      @matches = Match.includes(:mentor, :mentor_users, :mentee, :mentee_users, :schedules).where(mentee_id: current_user.mentee.id)
    end

    if @matches.blank?
      # 본인의 대쉬보드가 없을 경우 리다이렉트
      redirect_to root_path
    elsif @matches.size == 1
      # 본인의 대쉬보드가 1개만 있을 경우 리다이렉트
      redirect_to dashboard_path(@matches.first)
    end
  end

  def show
    respond_to do |format|
      format.html do
        @match = Match.includes(:mentor, :mentor_users, :mentee, :mentee_users, :schedules).find(params[:id])
        # 본인의 대쉬보드가 아닐 경우 리다이렉트
        return if (current_user.mentor? && @match.mentor_id == current_user.mentor.id) || (current_user.mentee? && @match.mentee_id == current_user.mentee.id)
        redirect_to dashboards_path
      end
      format.js
    end
  end

  def update
    @match = Match.find_by(params[:id])
    return if @match.update(match_params)
  end

  private

  def set_date_params
    match = params[:dashboard_id].nil? ? Match.find(params[:id]) : Match.find(params[:dashboard_id])
    @start_date =
      begin
        Time.zone.parse(params[:start_date]).beginning_of_day
      rescue
        Time.zone.now.beginning_of_week
      end
    @end_date =
      begin
        Time.zone.parse(params[:end_date]).end_of_day
      rescue
        Time.zone.now.end_of_week
      end
    @start_date = match.created_at.beginning_of_day if match.created_at > @start_date
    @end_date = @start_date.end_of_week if @start_date > @end_date
  end

  def match_params
    params
      .fetch(:match, {})
      .permit(:study, :school, :history, :korean, :english, :math)
  end
end
