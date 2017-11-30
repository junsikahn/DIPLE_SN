class Admin::TmpProblem < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :problem_source, class_name: 'Standard::ProblemSource'
  has_and_belongs_to_many :problem_tags

  def completed?
    return false if subject_id.nil?
    true
  end

  def objective?
    return false if exm_1.blank? && exm_2.blank? && exm_3.blank? && exm_4.blank?
    true
  end
end
