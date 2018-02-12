class Problem < ApplicationRecord
  belongs_to :subject, optional: true

  has_many :problem_subjects
  has_many :subjects, through: :problem_subjects
  has_many :problem_source_orders
  has_many :problem_sources, through: :problem_source_orders
  has_many :problem_collection_to_problems
  has_many :problem_collections, through: :problem_collection_to_problems

  belongs_to :problem_set, class_name: 'Problem', foreign_key: 'problem_id', optional: true
  has_many   :set_problems, class_name: 'Problem', foreign_key: 'problem_id', dependent: :destroy
  accepts_nested_attributes_for :set_problems

  has_many :problem_histories, dependent: :destroy

  has_and_belongs_to_many :problem_tags
  has_many :problem_images

  # validates :content, presence: true
  # validates :answer, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, if: 'self.is_objective' }
  # validates :exm_1, presence: { if: 'self.is_objective' }
  # validates :exm_2, presence: { if: 'self.is_objective' }
  # validates :exm_3, presence: { if: 'self.is_objective' }
  # validates :exm_4, presence: { if: 'self.is_objective' }
  # validates :exm_5, presence: { if: 'self.is_objective' }
  # validates :score, numericality: { greater_than: 0 }

  def updated?
    updated_at && updated_at > created_at
  end

  def ready?
    return false if subject_id.nil? || content.blank? || explanation.blank?
    true
  end

  def with_details_as_json
    as_json(include: [{problem_subjects: {include: :subject}},
                      {problem_source_orders: {include: :problem_source}},
                      {problem_images: {methods: :image_url}},
                      :problem_tags])
  end
end
