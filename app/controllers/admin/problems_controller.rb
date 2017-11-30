class Admin::ProblemsController < AdminController
  before_action :set_admin_problem, only: [:show, :edit, :update, :destroy, :publish]

  # GET /admin/problems
  # GET /admin/problems.json
  def index
    @admin_problems = Admin::Problem.includes(:subject, :problem_tags).page(params[:page]).per(params[:per])
  end

  def test
    if params[:problem_source_id]
      @problem_source = Standard::ProblemSource.find(params[:problem_source_id])
      @admin_problems = Admin::Problem.includes(:subject, :problem_tags, :problem_source).where(problem_source_id: params[:problem_source_id])
    else
      @problem_sources = Standard::ProblemSource.includes(:problems).all.order(:name)
    end
  end

  # GET /admin/problems/1
  # GET /admin/problems/1.json
  def show
  end

  # GET /admin/problems/new
  def new
    @admin_problem = Admin::Problem.new(subject: Admin::Subject.new)
    render 'form'
  end

  # GET /admin/problems/1/edit
  def edit
    @admin_problem.subject = Admin::Subject.new if @admin_problem.subject_id.nil?
    render 'form'
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
      if params[:redirect_url] && Rails.application.routes.recognize_path(params[:redirect_url])[:action] == 'test'
        redirect_to test_admin_problems_path(problem_source_id: @admin_problem.problem_source_id)
      elsif params[:redirect_url]
        redirect_to params[:redirect_url]
      else
        redirect_to @admin_problem
      end
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
    @admin_problem = Admin::Problem.includes(:subject, :problem_tags, :problem_source).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_problem_params
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
              problem_tag_ids: [])
  end
end
