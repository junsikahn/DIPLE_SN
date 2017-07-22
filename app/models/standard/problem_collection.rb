class Standard::ProblemCollection < ApplicationRecord
  scope :daily_tests, (->(start_date, end_date) { where(published: true, problem_source_id: 1).where('test_day > ? AND test_day < ?', start_date, end_date) })

  belongs_to :subject
  belongs_to :problem_source

  has_many :problem_collection_to_problems, dependent: :destroy
  has_many :problems, through: :problem_collection_to_problems
  accepts_nested_attributes_for :problems

  has_many :problem_collection_histories, dependent: :destroy

  has_attached_file :audio,
                    url: '/assets/problem_collections/:id/:attachment.:extension'
  validates_attachment_content_type :audio, content_type: ['audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio']
end
