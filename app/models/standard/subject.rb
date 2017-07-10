class Standard::Subject < ApplicationRecord
  default_scope { order(:order) }
  scope :main_subjects, (-> { where(subject_id: nil) })

  belongs_to :main, class_name: 'Standard::Subject', foreign_key: 'main_subject_id', optional: true
  has_many   :subs, class_name: 'Standard::Subject', foreign_key: 'main_subject_id'
  belongs_to :origin, class_name: 'Standard::Subject', foreign_key: 'subject_id', optional: true
  has_many   :details, class_name: 'Standard::Subject', foreign_key: 'subject_id'
  accepts_nested_attributes_for :details
end
