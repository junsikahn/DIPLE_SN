class Mentee < ApplicationRecord
  belongs_to :user
  has_many :careers, through: :user
  has_many :high_careers, -> { where(category: 'high') }, class_name: 'Career', through: :user
  has_many :favored_subjects, through: :user
  has_many :locations, through: :user
  has_many :schedules, through: :user

  has_many :matches
  has_many :mentors, -> { distinct }, through: :matches

  def grade
    Time.now.year - high_careers.first.entrance_year.year + 1
  end
end
