module Api
  class ProblemsController < ApplicationController
    # GET /problems
    def index
      respond_to do |format|
        format.html
        format.json do
          problems = Problem.includes({problem_subjects: [:subject]},
                                      {problem_source_orders: [:problem_source]},
                                      :problem_images,
                                      :problem_tags)
                            .page(params[:page])
                            .per(params[:per])
                            .as_json(include: [{problem_subjects: {include: :subject}},
                                               {problem_source_orders: {include: :problem_source}},
                                               {problem_images: {methods: :image_url}},
                                               :problem_tags])
          render json: problems
        end
      end
    end

    # GET /problems/:id
    def show
      respond_to do |format|
        format.html
        format.json do
          problem = Problem.find(params[:id])
                           .as_json(include: [{problem_subjects: {include: :subject}},
                                              {problem_source_orders: {include: :problem_source}},
                                              {problem_images: {methods: :image_url}},
                                              :problem_tags])
          render json: problem
        end
      end
    end
  end
end
