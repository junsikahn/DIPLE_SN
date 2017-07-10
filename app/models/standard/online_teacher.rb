class Standard::OnlineTeacher < ApplicationRecord
  belongs_to :provider, class_name: 'OnlineProvider', foreign_key: 'online_provider_id'
  has_many :lectures, class_name: 'OnlineLecture', foreign_key: 'online_teacher_id', dependent: :destroy

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: { scope: :online_provider_id }
end
