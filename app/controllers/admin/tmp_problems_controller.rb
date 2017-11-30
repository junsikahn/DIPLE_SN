class Admin::TmpProblemsController < AdminController
  before_action :set_tmp_problem, only: [:edit, :update]

  # GET /admin/tmp_problems
  # GET /admin/tmp_problems.json
  def index
    if params[:title].nil?
      @tmp_problems = Admin::TmpProblem.all.order(title: :asc)
    else
      @tmp_problems = Admin::TmpProblem.includes(:subject, :problem_tags).where(title: params[:title])
    end
  end

  # GET /admin/tmp_problems/1
  # GET /admin/tmp_problems/1.json
  # def show
  # end

  # GET /admin/tmp_problems/new
  # def new
  # end

  # def upload
  #   results = ConvertHwp.convert_hwp(params[:file])
  #   results.each do |result|
  #     tmp = Admin::TmpProblem.new(year: result[:year],
  #                                 title: result[:title],
  #                                 order: result[:order],
  #                                 content: result[:content],
  #                                 answer: result[:answer],
  #                                 score: result[:score],
  #                                 explanation: result[:explanation])
  #     if result[:exms]
  #       tmp.exm_1 = result[:exms][0]
  #       tmp.exm_2 = result[:exms][1]
  #       tmp.exm_3 = result[:exms][2]
  #       tmp.exm_4 = result[:exms][3]
  #       tmp.exm_5 = result[:exms][4]
  #     end
  #     tmp.save
  #   end
  #   redirect_to new_admin_tmp_problem_path
  # end

  # POST /admin/tmp_problems
  # POST /admin/tmp_problems.json
  # def create
  #   results = ConvertHwp.convert_hwp(params[:file])
  #   render json: { results: results }
  # end

  # GET /admin/tmp_problems/1/edit
  def edit
    # failed_list = []
    # tmp_problems = Admin::TmpProblem.all
    # tmp_problems.each do |tmp_problem|
    #   new_problem = Admin::Problem.new(score: tmp_problem.score, year: tmp_problem.year, content: tmp_problem.content, exm_1: tmp_problem.exm_1, exm_2: tmp_problem.exm_2, exm_3: tmp_problem.exm_3, exm_4: tmp_problem.exm_4, exm_5: tmp_problem.exm_5, answer: tmp_problem.answer, explanation: tmp_problem.explanation, problem_source_id: tmp_problem.problem_source_id, problem_source_order: tmp_problem.order)
    #   if new_problem.save
    #   else
    #     failed_list << tmp_problem.id
    #   end
    # end

    # @admin_problem = Admin::Problem.new(subject: Admin::Subject.new,
    #                                     subject_id: @tmp_problem.subject_id,
    #                                     score: @tmp_problem.score,
    #                                     level: @tmp_problem.level,
    #                                     content: @tmp_problem.content,
    #                                     exm_1: @tmp_problem.exm_1,
    #                                     exm_2: @tmp_problem.exm_2,
    #                                     exm_3: @tmp_problem.exm_3,
    #                                     exm_4: @tmp_problem.exm_4,
    #                                     exm_5: @tmp_problem.exm_5,
    #                                     explanation: @tmp_problem.explanation,
    #                                     answer: @tmp_problem.answer,
    #                                     year: @tmp_problem.year,
    #                                     problem_source_id: @tmp_problem.problem_source_id,
    #                                     problem_source_order: @tmp_problem.order)
  end

  # PATCH/PUT /admin/tmp_problems/1
  # PATCH/PUT /admin/tmp_problems/1.json
  def update
    @tmp_problem.subject = nil if @tmp_problem.subject_id.nil?
    if @tmp_problem.update(tmp_problem_params)
      # if @tmp_problem.completed?
      #   redirect_to admin_tmp_problems_path(title: @tmp_problem.title)
      # else
      #   render :edit
      # end
      redirect_to edit_admin_tmp_problem_path(@tmp_problem)
    else
      render :edit
    end
  end

  # DELETE /admin/tmp_problems/1
  # DELETE /admin/tmp_problems/1.json
  # def destroy
  #   @tmp_problem.destroy
  #   redirect_to admin_problems_path
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tmp_problem
    @tmp_problem = Admin::TmpProblem.includes(:subject, :problem_tags, :problem_source).find(params[:id])
    @tmp_problem.subject = Admin::Subject.new if @tmp_problem.subject.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tmp_problem_params
    params
      .require(:admin_tmp_problem)
      .permit(:subject_id, :content, :exm_1, :exm_2, :exm_3, :exm_4, :exm_5, :answer, :score, :level, :explanation)
  end
end
