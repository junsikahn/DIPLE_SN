class ProblemCollectionToProblem < ApplicationRecord
  default_scope { order(order: :asc) }

  belongs_to :problem_collection
  belongs_to :problem
  accepts_nested_attributes_for :problem

  validate :ordering

  def ordering
    self[:order] = ProblemCollectionToProblem.where(problem_collection_id: problem_collection_id).count
  end
end
