class App::Dashboards::CommentsController < App::DashboardsController
  before_action :set_date_params

  def index
    @comments = Comment.includes(:user, :subject, :reply_comments).where(match_id: params[:dashboard_id]).original_only.until(@start_date, @end_date)
  end

  def new
    @comment = Comment.new(match_id: params[:dashboard_id], user_id: current_user.id, subject_id: params[:subject_id], comment_id: params[:comment_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def edit
    @comments = Comment.includes(:user).where(match_id: params[:dashboard_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_update_params)
  end

  private

  def comment_params
    params
      .fetch(:comment, {})
      .permit(:match_id, :user_id, :subject_id, :content, :comment_id)
  end

  def comment_update_params
    params.permit(:completed_at)
  end
end
