class Standard::OnlineLecture < ApplicationRecord
  belongs_to :subject
  belongs_to :provider, class_name: 'OnlineProvider', foreign_key: 'online_provider_id'
  belongs_to :teacher, class_name: 'OnlineTeacher', foreign_key: 'online_teacher_id'
  accepts_nested_attributes_for :teacher, allow_destroy: true
  has_many :lists, class_name: 'OnlineLectureList', foreign_key: 'online_lecture_id', dependent: :destroy, inverse_of: :online_lecture
  accepts_nested_attributes_for :lists, allow_destroy: true

  has_many :online_lecture_histories, dependent: :destroy

  validates :uid, presence: true, uniqueness: true
  validates :title, presence: true
  validates :online_provider_id, presence: true

  def packages
    return Standard::OnlineLecture.none if package_ids.nil? || package_ids.split(',').size.zero?
    Standard::OnlineLecture.where(uid: package_ids.split(','))
  end

  def provider_name
    case self[:online_provider_id]
    when 1 then '메가스터디'
    when 2 then '대성마이맥'
    when 3 then '스카이에듀'
    when 4 then '이투스'
    end
  end
end
