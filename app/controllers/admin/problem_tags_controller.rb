class Admin::ProblemTagsController < AdminController
  before_action :set_admin_problem_tag, only: [:show, :edit, :update, :destroy, :publish]

  # GET /admin/problem_tags
  # GET /admin/problem_tags.json
  def index
    respond_to do |format|
      format.html do
        @admin_problem_tags = Admin::ProblemTag.page(params[:page]).per(params[:per])
      end
      format.json do
        if params[:q].blank?
          render json: []
        else
          render json: Admin::ProblemTag.where('keyword LIKE ?', "%#{params[:q]}%").as_json
        end
      end
    end
  end

  # GET /admin/problem_tags/1
  # GET /admin/problem_tags/1.json
  def show
  end

  # GET /admin/problem_tags/new
  def new
    @admin_problem_tag = Admin::ProblemTag.new()
    render 'form'
  end

  # GET /admin/problem_tags/1/edit
  def edit
    render 'form'
  end

  # POST /admin/problem_tags
  # POST /admin/problem_tags.json
  def create
    respond_to do |format|
      format.html do
        @admin_problem_tag = Admin::ProblemTag.new(admin_problem_tag_params)
        if @admin_problem_tag.save
          redirect_to @admin_problem_tag
        else
          render :new
        end
      end
      format.json do
        render json: Admin::ProblemTag.create(admin_problem_tag_params).as_json
      end
    end
  end

  # PATCH/PUT /admin/problem_tags/1
  # PATCH/PUT /admin/problem_tags/1.json
  def update
    if @admin_problem_tag.update(admin_problem_tag_params)
      redirect_to @admin_problem_tag
    else
      render :edit
    end
  end

  # DELETE /admin/problem_tags/1
  # DELETE /admin/problem_tags/1.json
  def destroy
    @admin_problem_tag.destroy
    redirect_to admin_problem_tags_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_problem_tag
    @admin_problem_tag = Admin::ProblemTag.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_problem_tag_params
    params[:admin_problem_tag][:keyword] = params[:admin_problem_tag][:name].gsub(/\s/, '') if params[:admin_problem_tag][:name]
    params
      .require(:admin_problem_tag)
      .permit(:name, :keyword)
  end
end
