class Standard::ProblemCollection < ApplicationRecord
  scope :daily_tests, (->(start_date, end_date) { where(published: true, problem_source_id: 1).where('test_day > ? AND test_day < ?', start_date, end_date) })

  belongs_to :subject
  belongs_to :problem_source

  has_many :problem_collection_to_problems, dependent: :destroy
  has_many :problems, through: :problem_collection_to_problems
  accepts_nested_attributes_for :problems

  has_many :problem_collection_histories, dependent: :destroy

  # has_one :match_history, -> (match_id) { where(match_id: match_id) }, class_name: 'ProblemCollectionHistory', foreign_key: 'problem_collection_id'
end
