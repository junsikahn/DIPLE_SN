class Admin::ProblemsController < AdminController
  before_action :set_admin_problem, only: [:show, :edit, :update, :destroy, :publish]

  # GET /admin/problems
  # GET /admin/problems.json
  def index
    @admin_problems = Admin::Problem.includes(:subject, :problem_tags).page(params[:page]).per(params[:per])
  end

  # GET /admin/problems/1
  # GET /admin/problems/1.json
  def show
    respond_to do |format|
      format.html
      format.json do
        render json: @admin_problem
      end
    end
  end

  # GET /admin/problems/new
  def new
    @admin_problem = Admin::Problem.new
    params.each { |key, value| @admin_problem[key] = value if @admin_problem.has_attribute?(key) }
  end

  # GET /admin/problems/1/edit
  def edit
  end

  # POST /admin/problems
  # POST /admin/problems.json
  def create
    @admin_problem = Admin::Problem.new(admin_problem_params)
    if @admin_problem.save
      redirect_to @admin_problem
    else
      render :new
    end
  end

  # PATCH/PUT /admin/problems/1
  # PATCH/PUT /admin/problems/1.json
  def update
    if @admin_problem.update(admin_problem_params)
      redirect_to @admin_problem
    else
      render :edit
    end
  end

  # DELETE /admin/problems/1
  # DELETE /admin/problems/1.json
  def destroy
    @admin_problem.destroy
    redirect_to admin_problems_path
  end

  def source
    data = params[:source]
    problem_source = Admin::ProblemSource.find_or_create_by(year: data[:year], time: data[:time], subject_id: data[:subject_id], curriculum: data[:curriculum], grade: data[:grade])
    source_problems = Admin::Problem.where(problem_source_id: problem_source.id)
    source_problems = source_problems.where.not(id: params[:problem_id]) unless params[:problem_id].blank?
    render json: { source: problem_source, occupied_orders: source_problems.pluck(:problem_source_order) }
  end

  def list
    subject_id = params[:admin_problem][:subject_id]
    if subject_id == '0'
      result = { details: Admin::Subject.main_subjects.select(:id, :path).to_json }
    else
      target = Admin::Subject.find(subject_id)
      result = { details: target.details.select(:id, :path).to_json }
    end
    render json: result
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_problem
    @admin_problem = Admin::Problem.includes(:subject, :problem_images, :problem_tags, :problem_source).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_problem_params
    params[:admin_problem][:problem_image_ids] = params[:admin_problem][:problem_image_ids].split(',') if params[:admin_problem][:problem_image_ids]
    params[:admin_problem][:problem_tag_ids] = params[:admin_problem][:problem_tag_ids].split(',') if params[:admin_problem][:problem_tag_ids]
    params
      .require(:admin_problem)
      .permit(:subject_id,
              :score,
              :level,
              :content,
              :exm_1,
              :exm_2,
              :exm_3,
              :exm_4,
              :exm_5,
              :explanation,
              :answer,
              :year,
              :problem_source_id,
              :problem_source_order,
              :is_objective,
              :correct_ratio,
              :exm_1_ratio,
              :exm_2_ratio,
              :exm_3_ratio,
              :exm_4_ratio,
              :exm_5_ratio,
              problem_image_ids: [],
              problem_tag_ids: [])
  end
end
