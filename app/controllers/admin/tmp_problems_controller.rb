class Admin::TmpProblemsController < AdminController
  before_action :set_tmp_problem, only: [:edit, :update, :destroy, :publish]

  # GET /admin/problems
  # GET /admin/problems.json
  def index
    # @tmp_problems = Admin::TmpProblem.page(params[:page]).per(params[:per])
    if params[:title].nil?
      @tmp_problems = Admin::TmpProblem.all.order(title: :asc)
    else
      @tmp_problems = Admin::TmpProblem.where(title: params[:title])
    end
  end

  # GET /admin/problems/1
  # GET /admin/problems/1.json
  def show
    @tmp_problems = Admin::TmpProblem.where(title: params[:title])
  end

  # GET /admin/problems/new
  def new
  end

  # GET /admin/problems/1/edit
  def edit
  end

  # POST /admin/problems
  # POST /admin/problems.json
  def create
    results = ConvertHwp.convert_hwp(params[:file])
    render json: { results: results }
  end

  def upload
    results = ConvertHwp.convert_hwp(params[:file])
    results.each do |result|
      tmp = Admin::TmpProblem.new(year: result[:year],
                                  title: result[:title],
                                  order: result[:order],
                                  content: result[:content],
                                  answer: result[:answer],
                                  score: result[:score],
                                  explanation: result[:explanation])
      if result[:exms]
        tmp.exm_1 = result[:exms][0]
        tmp.exm_2 = result[:exms][1]
        tmp.exm_3 = result[:exms][2]
        tmp.exm_4 = result[:exms][3]
        tmp.exm_5 = result[:exms][4]
      end
      tmp.save
    end
    redirect_to new_admin_tmp_problem_path
  end

  # PATCH/PUT /admin/problems/1
  # PATCH/PUT /admin/problems/1.json
  def update
    if @tmp_problem.update(subject_id: params[:subject_id])
      render json: { status: 'success' }
    else
      render json: { status: 'fail' }
    end
  end

  # DELETE /admin/problems/1
  # DELETE /admin/problems/1.json
  def destroy
    @tmp_problem.destroy
    redirect_to admin_problems_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tmp_problem
    @tmp_problem = Admin::TmpProblem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tmp_problem_params
    params
      .require(:tmp_problem)
      .permit()
  end
end
