class Admin::ProblemCollectionProblemSetsController < AdminController
  before_action :set_admin_problem_collection, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_admin_problem_set, only: [:edit, :update, :destroy]

  def index
    redirect_to @admin_problem_collection
  end

  def list
    target = Admin::Subject.find(params[:admin_problem][:subject_id])
    render json: { details: target.details.select(:id, :path).to_json }
  end

  # GET /admin/problems/new
  def new
    @admin_problem_set = @admin_problem_collection.admin_problems.new(subject_id: params[:subject_id], set: true)
    @admin_problem_set.set_problems.build(subject_id: params[:subject_id])
    render :form
  end

  # GET /admin/problems/1/edit
  def edit
    render :form
  end

  # POST /admin/problems
  # POST /admin/problems.json
  def create
    @admin_problem_set = Admin::Problem.new(admin_problem_params)
    if @admin_problem_set.save
      @admin_problem_collection.problems << @admin_problem_set
      @admin_problem_set.scoring(@admin_problem_collection)
      redirect_to @admin_problem_collection
    else
      render :form
    end
  end

  # PATCH/PUT /admin/problems/1
  # PATCH/PUT /admin/problems/1.json
  def update
    if @admin_problem_set.update(admin_problem_params)
      @admin_problem_set.scoring(@admin_problem_collection)
      redirect_to @admin_problem_collection
    else
      render :form
    end
  end

  # DELETE /admin/problems/1
  # DELETE /admin/problems/1.json
  def destroy
    @admin_problem_collection.problems.destroy(@admin_problem_set)
    @admin_problem_set.destroy
    @admin_problem_set.scoring(@admin_problem_collection)
    redirect_to @admin_problem_collection
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_problem_collection
      @admin_problem_collection = Admin::ProblemCollection.find(params[:problem_collection_id])
    end
    def set_admin_problem_set
      @admin_problem_set = Admin::Problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_problem_params
      params
        .require(:admin_problem)
        .permit(:subject_id, :content, :set,
                set_problems_attributes: [:subject_id, :content, :exm_1, :exm_2, :exm_3, :exm_4, :exm_5, :answer, :score, :explanation])
    end
end
