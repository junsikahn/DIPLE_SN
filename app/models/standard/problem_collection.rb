class Standard::ProblemCollection < ApplicationRecord
  scope :daily_tests, (->(start_date, end_date) { where(published: true, problem_source_id: 1).where('test_day > ? AND test_day < ?', start_date, end_date) })

  belongs_to :subject
  belongs_to :problem_source, optional: true

  has_many :problem_collection_to_problems, dependent: :destroy
  has_many :problems, through: :problem_collection_to_problems
  accepts_nested_attributes_for :problems

  has_many :problem_collection_histories, dependent: :destroy

  def curriculum_name
    case curriculum
    when 1
      '수학가형'
    when 2
      '수학나형'
    end
  end
end
