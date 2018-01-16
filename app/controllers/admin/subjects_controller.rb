class Admin::SubjectsController < AdminController
  before_action :set_admin_subject, only: [:edit, :update, :destroy]

  # GET /admin/subjects
  # GET /admin/subjects.json
  def index
    @admin_subjects = Admin::Subject.includes(details: [details: :details]).main_subjects
  end

  # GET /admin/subjects/new
  def new
    @admin_subject = Admin::Subject.new
  end

  # GET /admin/subjects/1/edit
  def edit
  end

  # POST /admin/subjects
  # POST /admin/subjects.json
  def create
    @admin_subject = Admin::Subject.new(admin_subject_params)

    respond_to do |format|
      if @admin_subject.save
        format.html { redirect_to @admin_subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @admin_subject }
      else
        format.html { render :new }
        format.json { render json: @admin_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/subjects/1
  # PATCH/PUT /admin/subjects/1.json
  def update
    respond_to do |format|
      if @admin_subject.update(admin_subject_params)
        format.html { redirect_to @admin_subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_subject }
      else
        format.html { render :edit }
        format.json { render json: @admin_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/subjects/1
  # DELETE /admin/subjects/1.json
  def destroy
    @admin_subject.destroy
    respond_to do |format|
      format.html { redirect_to admin_subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_subject
      @admin_subject = Admin::Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_subject_params
      params
        .fetch(:admin_subject, {})
        .permit()
    end
end
