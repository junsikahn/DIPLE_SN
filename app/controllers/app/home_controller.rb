class App::HomeController < ApplicationController
  # GET /
  def index
    if params[:problem_source_id]
      @problem_source = ProblemSource.find(params[:problem_source_id])
      @problems = Problem.includes(:subject, :problem_tags, :problem_source).where(problem_source_id: params[:problem_source_id])
    else
      @problem_sources = ProblemSource.includes(:problems).all.order(:name)
    end

    # @problem_collections =
    #   ProblemCollection
    #     .joins("LEFT JOIN problem_collection_histories ON problem_collection_histories.problem_collection_id = problem_collections.id AND problem_collection_histories.user_id = #{current_user.id}")
    #     .select('problem_collections.*, problem_collection_histories.score')
    #     .where(published: true)
    #     .where('test_day <= ?', Date.today)
    #
    # @problem_histories = ProblemHistory.where(user_id: current_user.id, correct: false)
  end

  def new
    # respond_to do |format|
    #   format.html
    #   format.js do
    #     @problem_collection_history = ProblemCollectionHistory.includes(problem_collection: [:subject, problems: [:subject]]).find_by(user_id: current_user.id, problem_collection_id: params[:problem_collection_id])
    #     if @problem_collection_history.nil?
    #       @problem_collection_history = ProblemCollectionHistory.new(user_id: current_user.id, problem_collection_id: params[:problem_collection_id])
    #       @problem_collection_history.build_problems
    #     else
    #       @my_problem_histories = ProblemHistory.includes(problem: :subject).where(user_id: current_user.id, problem_id: @problem_collection_history.problem_collection.problems.pluck(:id))
    #       render :show
    #     end
    #   end
    # end
  end

  def create
    # @problem_collection_history = ProblemCollectionHistory.new(problem_collection_history_params)
    # if @problem_collection_history.save
    #   @my_problem_histories = ProblemHistory.includes(problem: :subject).where(user_id: current_user.id, problem_id: @problem_collection_history.problem_collection.problems.pluck(:id))
    #   render :show
    # else
    #   render :new
    # end
  end

  private

  def problem_collection_history_params
    # params
    #   .fetch(:problem_collection_history, {})
    #   .permit(:user_id, :problem_collection_id,
    #           problem_histories_attributes: [:user_id, :users_answer, :subject_id, :problem_collection_id, :problem_id])
  end
end
