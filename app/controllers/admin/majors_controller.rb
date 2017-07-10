class Admin::MajorsController < AdminController
  before_action :set_admin_major, only: [:show, :edit, :update, :destroy]

  # GET /admin/majors
  # GET /admin/majors.json
  def index
    @admin_majors = Admin::Major.page(params[:page]).per(params[:per])
  end

  # GET /admin/majors/1
  # GET /admin/majors/1.json
  def show
  end

  # GET /admin/majors/new
  def new
    @admin_major = Admin::Major.new
  end

  # GET /admin/majors/1/edit
  def edit
  end

  # POST /admin/majors
  # POST /admin/majors.json
  def create
    @admin_major = Admin::Major.new(admin_major_params)

    respond_to do |format|
      if @admin_major.save
        format.html { redirect_to @admin_major, notice: 'Major was successfully created.' }
        format.json { render :show, status: :created, location: @admin_major }
      else
        format.html { render :new }
        format.json { render json: @admin_major.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/majors/1
  # PATCH/PUT /admin/majors/1.json
  def update
    respond_to do |format|
      if @admin_major.update(admin_major_params)
        format.html { redirect_to @admin_major, notice: 'Major was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_major }
      else
        format.html { render :edit }
        format.json { render json: @admin_major.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/majors/1
  # DELETE /admin/majors/1.json
  def destroy
    @admin_major.destroy
    respond_to do |format|
      format.html { redirect_to admin_majors_url, notice: 'Major was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_major
      @admin_major = Admin::Major.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_major_params
      params.require(:admin_major).permit(:name)
    end
end
