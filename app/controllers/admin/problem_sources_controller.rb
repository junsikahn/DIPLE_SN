class Admin::ProblemSourcesController < AdminController
  require 'convert_hwp'

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
      if !params[:problems].blank? && @admin_problem_source.problems.length == 0
        params[:problems].each do |_index, param|
          @admin_problem_source.problems.create(score: param[:score],
                                                year: param[:year],
                                                content: param[:content],
                                                exm_1: param[:exm_1],
                                                exm_2: param[:exm_2],
                                                exm_3: param[:exm_3],
                                                exm_4: param[:exm_4],
                                                exm_5: param[:exm_5],
                                                answer: param[:answer],
                                                explanation: param[:explanation],
                                                problem_source_id: param[:problem_source_id],
                                                problem_source_order: param[:problem_source_order],
                                                is_objective: param[:is_objective])
        end
      end
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

  def preview
    # 2018_04_경기_학력평가_수학_가형_고3.hwp
    name = params[:file].original_filename.sub('.xml', '')
    parts = name.split('_')
    year = parts[0][0..3].to_i
    time = parts[1][0..1].to_i
    location = case time
               when 6 then 0
               when 9 then 0
               when 11 then 0
               when 3 then 1
               when 4 then 2
               when 7 then 3
               when 10 then 1
               end
    institute = case time
                when 6 then 0
                when 9 then 0
                when 11 then 0
                when 3 then 1
                when 4 then 1
                when 7 then 1
                when 10 then 1
                end
    curriculum = parts[2]
    source_params = {
      year: year,
      time: time,
      location: location,
      institute: institute,
      subject_id: 3,
      curriculum: curriculum,
      grade: 3
    }
    problem_source = Admin::ProblemSource.find_or_create_by(source_params)
    if problem_source.new_record? || problem_source.problems.length.zero?
      datas = ConvertHwp.convert_hwp(params[:file])
      datas.each do |data|
        problem_source.problems.build(data)
      end
      is_new_file = true
    else
      is_new_file = false
    end
    render json: {
      is_new_file: is_new_file,
      problem_source: problem_source,
      problems: problem_source.problems
    }
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
              :grade,
              :location,
              :institute)
  end
end
