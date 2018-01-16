class Admin::ProblemSourcesController < AdminController
  before_action :set_admin_problem_source, only: [:show, :edit, :update, :destroy, :publish]

  # GET /admin/problem_sources
  # GET /admin/problem_sources.json
  def index
    @admin_problem_sources = Admin::ProblemSource.includes(:problems).all.order(:name)
  end

  # GET /admin/problem_sources/1
  # GET /admin/problem_sources/1.json
  def show
  end

  # GET /admin/problem_sources/new
  def new
    @admin_problem_source = Admin::ProblemSource.new
    render 'form'
  end

  # GET /admin/problem_sources/1/edit
  def edit
    render 'form'
  end

  # POST /admin/problem_sources
  # POST /admin/problem_sources.json
  def create
    @admin_problem_source = Admin::ProblemSource.find_by(admin_problem_source_params)
    if !@admin_problem_source.nil?
      redirect_to @admin_problem_source
    else
      @admin_problem_source = Admin::ProblemSource.new(admin_problem_source_params)
      if @admin_problem_source.save
        redirect_to @admin_problem_source
      else
        render :new
      end
    end
  end

  # PATCH/PUT /admin/problem_sources/1
  # PATCH/PUT /admin/problem_sources/1.json
  def update
    if @admin_problem_source.update(admin_problem_source_params)
      redirect_to @admin_problem_source
    else
      render :edit
    end
  end

  # DELETE /admin/problem_sources/1
  # DELETE /admin/problem_sources/1.json
  def destroy
    @admin_problem_source.destroy
    redirect_to admin_problems_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_problem_source
    @admin_problem_source = Admin::ProblemSource.includes(problems: [:subject, :problem_tags, :problem_source]).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_problem_source_params
    params[:admin_problem_source][:subject_id] = 3 unless params[:admin_problem_source][:subject_id]
    params[:admin_problem_source][:grade] = 3 unless params[:admin_problem_source][:grade]
    params
      .require(:admin_problem_source)
      .permit(:year,
              :time,
              :subject_id,
              :curriculum,
              :grade)
  end
end
