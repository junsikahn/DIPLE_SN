class Standard::OnlineProvider < ApplicationRecord
  has_many :teachers, class_name: 'OnlineTeacher', foreign_key: 'online_provider_id', dependent: :destroy
  has_many :lectures, class_name: 'OnlineLecture', foreign_key: 'online_provider_id', dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
