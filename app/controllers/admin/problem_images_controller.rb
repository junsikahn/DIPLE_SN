class Admin::ProblemImagesController < AdminController
  before_action :set_admin_problem_image, only: [:show]

  def show
    respond_to do |format|
      format.json { render json: @admin_problem_image.as_json({methods: :image_url}) }
    end
  end

  # POST /admin/problem_images
  # POST /admin/problem_images.json
  def create
    respond_to do |format|
      format.json do
        admin_problem_image = Standard::ProblemImage.new
        admin_problem_image.image = params[:File]
        if admin_problem_image.save
          render json: { status: 200, image: admin_problem_image, url: admin_problem_image.image.url }
        else
          render json: { status: 400 }
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_problem_image
    @admin_problem_image = Standard::ProblemImage.find(params[:id])
  end
end
