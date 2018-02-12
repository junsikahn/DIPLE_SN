class ProblemHistory < ApplicationRecord
  belongs_to :user
  belongs_to :subject, class_name: 'Subject'
  belongs_to :problem, class_name: 'Problem', counter_cache: :total_count
  belongs_to :problem_collection, class_name: 'ProblemCollection'
  belongs_to :problem_collection_history, optional: true

  validate :check_answer

  def check_answer
    errors.add(:users_answer) and return if users_answer.blank?
    self[:correct] = users_answer == problem.answer
  end
end
