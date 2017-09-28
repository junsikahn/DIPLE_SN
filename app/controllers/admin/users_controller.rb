class Admin::UsersController < AdminController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
    @admin_users = Admin::User.includes(:problem_collection_histories).page(params[:page]).per(params[:per])
    @admin_users = @admin_users.where('name LIKE ?', "%#{params[:q]}%") unless params[:q].nil?
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    @problem_collection_histories = ProblemCollectionHistory.includes(problem_collection: :problem_source).where(user_id: @admin_user.id)
  end

  # GET /admin/users/new
  def new
    @admin_user = Admin::User.new
    render :form
  end

  # GET /admin/users/1/edit
  def edit
    render :form
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @admin_user = Admin::User.new(admin_user_params)

    # 임시비밀번호 부여 (생년월일 6자리)
    @admin_user.password = @admin_user.tmp_password

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to @admin_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @admin_user }
      else
        format.html { render :form }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to @admin_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_user }
      else
        format.html { render :form }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report
    # @users = User.includes(:problem_collection_histories, :problem_histories).all
    @problem_collections = Standard::ProblemCollection.where(published: true).where('test_day <= ?', Date.today)
    @start_date = Time.zone.parse('2017-07-24').beginning_of_day
    @end_date = Time.zone.parse('2017-08-15').beginning_of_day
  end

  def report_user
    # @user = User.includes(:problem_collection_histories, :problem_histories).where(id: params[:id])
    user = User.where(id: params[:id]).select(:id, :name, :liberal).first
    problem_collection_histories = ProblemCollectionHistory.where(user_id: user.id).select(:problem_collection_id, :score)
    problem_histories = ProblemHistory.includes(:problem).where(user_id: user.id).as_json(include: [:problem])

    render json: {
      user: user,
      problem_collection_histories: problem_collection_histories,
      problem_histories: problem_histories
    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_user
    @admin_user = Admin::User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_user_params
    params
      .fetch(:admin_user, {})
      .permit(:uid, :name, :gender, :liberal, :birthday)
  end
end
