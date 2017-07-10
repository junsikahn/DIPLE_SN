class ProblemCollectionHistory < ApplicationRecord
  belongs_to :match
  belongs_to :problem_collection, class_name: 'Standard::ProblemCollection', counter_cache: :solved_count

  has_many :problem_histories, dependent: :destroy
  accepts_nested_attributes_for :problem_histories

  before_create :scoring

  def build_problems
    problem_collection.problems.each do |problem|
      if problem.set?
        problem.set_problems.each do |set_problem|
          problem_histories.build(match_id: match_id, subject_id: set_problem.subject_id, problem_collection_id: problem_collection.id, problem_id: set_problem.id)
        end
      else
        problem_histories.build(match_id: match_id, subject_id: problem.subject_id, problem_collection_id: problem_collection.id, problem_id: problem.id)
      end
    end
  end

  def scoring
    self[:score] = 0
    self[:completed_at] = Time.zone.now
    problem_histories.each do |problem_history|
      next unless problem_history.correct?
      problem_history.problem.correct_count += 1
      self[:score] += problem_history.problem.score
      problem_history.problem.save
    end
  end
end
