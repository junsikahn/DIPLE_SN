class Admin::OnlineLecturesController < AdminController
  before_action :set_admin_online_lecture, only: [:show, :edit, :update, :destroy]

  # GET /admin/online_lectures
  def index
    @admin_online_lectures = Admin::OnlineLecture.includes(:subject, :teacher, :lists)
                                                 .page(params[:page]).per(params[:per])
  end

  # GET /admin/online_lectures/1
  def show
  end

  # GET /admin/online_lectures/new
  def new
    @admin_online_lecture = Admin::OnlineLecture.new(subject_id: params[:subject_id], uid: params[:uid])
  end

  # GET /admin/online_lectures/1/edit
  def edit
  end

  # POST /admin/online_lectures
  def create
    @admin_online_lecture = Admin::OnlineLecture.new(admin_online_lecture_params)

    if @admin_online_lecture.title.blank?
      @admin_online_lecture.valid_url? && @admin_online_lecture.parse_lists(admin_online_lecture_params[:subject_id])
      render :new
    elsif @admin_online_lecture.save
      redirect_to @admin_online_lecture
    else
      render :new
    end
  end

  # PATCH/PUT /admin/online_lectures/1
  def update
    if @admin_online_lecture.update(admin_online_lecture_params)
      redirect_to admin_online_lectures_path
    else
      render :edit
    end
  end

  # DELETE /admin/online_lectures/1
  def destroy
    @admin_online_lecture.destroy
    redirect_to admin_online_lectures_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_online_lecture
    @admin_online_lecture = Admin::OnlineLecture.includes(:subject, :teacher, :lists).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_online_lecture_params
    params
      .fetch(:admin_online_lecture, {})
      .permit(:id, :subject_id, :online_provider_id, :uid, :title, :online_teacher_id, :target, :lecture_count, :is_completed, :package_ids, :is_collected,
              teacher_attributes: [:id, :subject_id, :online_provider_id, :name, :uid],
              lists_attributes: [:id, :online_lecture_id, :order, :title, :time, :_destroy])
  end
end
