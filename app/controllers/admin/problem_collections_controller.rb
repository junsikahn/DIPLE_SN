class Admin::ProblemCollectionsController < AdminController
  before_action :set_admin_problem_collection, only: [:show, :edit, :update, :destroy, :publish]

  # GET /admin/problem_collections
  # GET /admin/problem_collections.json
  def index
    @admin_problem_collections = Admin::ProblemCollection.includes(:subject, :problem_source).page(params[:page]).per(params[:per])
  end

  # GET /admin/problem_collections/1
  # GET /admin/problem_collections/1.json
  def show
    @users =
      User
        .joins("LEFT JOIN problem_collection_histories ON problem_collection_histories.problem_collection_id = #{@admin_problem_collection.id} AND problem_collection_histories.user_id = users.id")
        .select('users.uid, users.name, problem_collection_histories.score, problem_collection_histories.created_at')
        .order('problem_collection_histories.score DESC')
        .where.not(id: [1,2,67])
  end

  # GET /admin/problem_collections/new
  def new
    @admin_problem_collection = Admin::ProblemCollection.new(problem_source_id: params[:problem_source_id], subject_id: params[:subject_id], test_day: params[:test_day])
  end

  # GET /admin/problem_collections/1/edit
  def edit
  end

  # POST /admin/problem_collections
  # POST /admin/problem_collections.json
  def create
    @admin_problem_collection = Admin::ProblemCollection.new(admin_problem_collection_params)
    if @admin_problem_collection.problem_source_id == 2 && @admin_problem_collection.problems.blank?
      @admin_problem_collection.create_word_test(admin_problem_collection_params[:excel].to_io)
      render :new
    elsif @admin_problem_collection.save
      redirect_to @admin_problem_collection
    else
      render :new
    end
  end

  # PATCH/PUT /admin/problem_collections/1
  # PATCH/PUT /admin/problem_collections/1.json
  def update
    if @admin_problem_collection.update(admin_problem_collection_params)
      redirect_to @admin_problem_collection
    else
      render :edit
    end
  end

  def publish
    @admin_problem_collection.toggle(:published).save
    redirect_to @admin_problem_collection
  end

  # DELETE /admin/problem_collections/1
  # DELETE /admin/problem_collections/1.json
  def destroy
    @admin_problem_collection.destroy
    redirect_to admin_problem_collections_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_problem_collection
      @admin_problem_collection = Admin::ProblemCollection.includes(:subject, :problem_source, problems: :subject).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_problem_collection_params
      params
        .require(:admin_problem_collection)
        .permit(:name, :test_day, :subject_id, :problem_source_id, :audio,
                :excel,
                problems_attributes: [:id, :subject_id, :content, :exm_1, :exm_2, :exm_3, :exm_4, :exm_5, :answer, :score])
    end
end
