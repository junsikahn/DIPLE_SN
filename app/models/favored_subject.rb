class FavoredSubject < ApplicationRecord
  belongs_to :user
  belongs_to :subject, class_name: 'Standard::Subject'

  validates :subject_id, presence: true, uniqueness: { scope: :user_id }
end
