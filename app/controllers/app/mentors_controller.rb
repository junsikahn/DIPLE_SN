class App::MentorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  semantic_breadcrumb 'Mentors', :mentors_path

  # mentors_path GET /mentors
  def index
    @mentors = Mentor.where.not(recruited_at: nil, authorized_at: nil)
  end

  # mentor_path GET /mentors/:id
  def show
    @mentor = Mentor.find(params[:id])
    if @mentor.recruited_at? && @mentor.authorized_at?
      semantic_breadcrumb "#{@mentor.user.name} 선생님"
    else
      redirect_to mentors_path
    end
  end
end
