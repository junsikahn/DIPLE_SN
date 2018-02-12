class ProblemSource < ApplicationRecord
  has_many :problem_source_orders
  has_many :problems, through: :problem_source_orders, dependent: :destroy

  def problems_with_details_as_json
    problems.as_json(include: [{problem_subjects: {include: :subject}},
                               {problem_source_orders: {include: :problem_source}},
                               {problem_images: {methods: :image_url}},
                               :problem_tags])
  end
end
