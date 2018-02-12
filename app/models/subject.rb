class Subject < ApplicationRecord
  default_scope { order(:order) }
  scope :main_subjects, (-> { where(subject_id: nil) })
  scope :kor, (-> { where(id: 1) })
  scope :eng, (-> { where(id: 2) })
  scope :math, (-> { where(id: 3) })
  scope :maths, (-> { includes(details: [details: :details]).find(3).as_json(include: [details: {include: [details: {include: :details}]}]) })

  belongs_to :main, class_name: 'Subject', foreign_key: 'main_subject_id', optional: true
  has_many   :subs, class_name: 'Subject', foreign_key: 'main_subject_id'
  belongs_to :origin, class_name: 'Subject', foreign_key: 'subject_id', optional: true
  has_many   :details, class_name: 'Subject', foreign_key: 'subject_id'
  accepts_nested_attributes_for :details

  has_many :problem_subjects
  has_many :problems, through: :problem_subjects
end
