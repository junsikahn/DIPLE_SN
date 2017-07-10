class Standard::OnlineLectureList < ApplicationRecord
  default_scope { order(order: :asc) }

  belongs_to :online_lecture, inverse_of: :lists
  has_many :online_lecture_histories, dependent: :destroy

  validates :order, uniqueness: { scope: :online_lecture_id } # 최초 association 빌드시에는 적용되지 않는 단점이 있음

  def order_to_s
    self[:order].zero? ? 'OT' : "#{self[:order]}회차"
  end

  def time_to_s
    self[:time].nil? ? '-' : "#{self[:time]}분"
  end
end
