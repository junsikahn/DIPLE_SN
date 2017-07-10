class Standard::Problem < ApplicationRecord
  belongs_to :subject
  has_many :problem_collection_to_problems
  has_many :problem_collections, through: :problem_collection_to_problems

  belongs_to :problem_set, class_name: 'Standard::Problem', foreign_key: 'problem_id', optional: true
  has_many   :set_problems, class_name: 'Standard::Problem', foreign_key: 'problem_id', dependent: :destroy
  accepts_nested_attributes_for :set_problems

  has_attached_file :content_image, default_url: '/images/image_preview.png'
  has_attached_file :answer_image, default_url: '/images/image_preview.png'
  has_attached_file :audio, default_url: '/images/banner_sound.mp3'

  # validates :content, presence: true
  # validates :answer, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, if: 'self.objective?' }
  # validates :exm_2, presence: { if: 'self.objective?' }
  # validates :exm_3, presence: { if: 'self.objective?' }
  # validates :exm_4, presence: { if: 'self.objective?' }
  # validates :exm_5, presence: { if: 'self.objective?' }
  # validates :score, numericality: { greater_than: 0 }

  def objective?
    return false if exm_1.blank? && exm_2.blank? && exm_3.blank? && exm_4.blank? && exm_5.blank?
    true
  end
end
