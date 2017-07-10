class ProblemHistory < ApplicationRecord
  belongs_to :match
  belongs_to :subject, class_name: 'Standard::Subject'
  belongs_to :problem, class_name: 'Standard::Problem', counter_cache: :total_count
  belongs_to :problem_collection, class_name: 'Standard::ProblemCollection'
  belongs_to :problem_collection_history, optional: true

  validate :scoring

  def scoring
    errors.add(:users_answer) and return if users_answer.blank?
    self[:correct] = users_answer == problem.answer
  end
end
