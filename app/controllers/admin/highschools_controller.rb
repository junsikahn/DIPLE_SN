class Admin::HighschoolsController < AdminController
  before_action :set_admin_highschool, only: [:show, :edit, :update, :destroy]

  # GET /admin/highschools
  # GET /admin/highschools.json
  def index
    @admin_highschools = Admin::Highschool.page(params[:page]).per(params[:per])
  end

  # GET /admin/highschools/1
  # GET /admin/highschools/1.json
  def show
  end

  # GET /admin/highschools/new
  def new
    @admin_highschool = Admin::Highschool.new
  end

  # GET /admin/highschools/1/edit
  def edit
  end

  # POST /admin/highschools
  # POST /admin/highschools.json
  def create
    @admin_highschool = Admin::Highschool.new(admin_highschool_params)

    respond_to do |format|
      if @admin_highschool.save
        format.html { redirect_to @admin_highschool, notice: 'Highschool was successfully created.' }
        format.json { render :show, status: :created, location: @admin_highschool }
      else
        format.html { render :new }
        format.json { render json: @admin_highschool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/highschools/1
  # PATCH/PUT /admin/highschools/1.json
  def update
    respond_to do |format|
      if @admin_highschool.update(admin_highschool_params)
        format.html { redirect_to @admin_highschool, notice: 'Highschool was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_highschool }
      else
        format.html { render :edit }
        format.json { render json: @admin_highschool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/highschools/1
  # DELETE /admin/highschools/1.json
  def destroy
    @admin_highschool.destroy
    respond_to do |format|
      format.html { redirect_to admin_highschools_url, notice: 'Highschool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_highschool
      @admin_highschool = Admin::Highschool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_highschool_params
      params.require(:admin_highschool).permit(:name)
    end
end
