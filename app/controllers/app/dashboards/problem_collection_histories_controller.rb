class App::Dashboards::ProblemCollectionHistoriesController < App::DashboardsController
  before_action :set_date_params

  def index
    @problem_collections =
      Standard::ProblemCollection
        .joins("LEFT JOIN problem_collection_histories ON problem_collection_histories.problem_collection_id = problem_collections.id AND problem_collection_histories.match_id = #{params[:dashboard_id]}")
        .select('problem_collections.*, problem_collection_histories.score')
        .daily_tests(@start_date, @end_date)
  end

  def new
    @problem_collection_history = ProblemCollectionHistory.includes(problem_collection: :problems, problem_histories: :problem).find_by(match_id: params[:dashboard_id], problem_collection_id: params[:problem_collection_id])
    if @problem_collection_history.nil?
      @problem_collection_history = ProblemCollectionHistory.new(match_id: params[:dashboard_id], problem_collection_id: params[:problem_collection_id])
      @problem_collection_history.build_problems
    else
      render :show
    end
  end

  def create
    @problem_collection_history = ProblemCollectionHistory.new(problem_collection_history_params)
    return if @problem_collection_history.save
    render :new
  end

  private

  def problem_collection_history_params
    params
      .fetch(:problem_collection_history, {})
      .permit(:match_id, :problem_collection_id,
              problem_histories_attributes: [:users_answer, :match_id, :subject_id, :problem_collection_id, :problem_id])
  end
end
