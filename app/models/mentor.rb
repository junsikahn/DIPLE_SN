class Mentor < ApplicationRecord
  belongs_to :user
  has_many :careers, through: :user
  has_many :favored_subjects, through: :user
  has_many :locations, through: :user
  has_many :schedules, through: :user

  has_many :matches
  has_many :mentees, -> { distinct }, through: :matches

  validates :self_introduction, length: { minimum: 10, on: :update, allow_blank: true }
  validates :bank_name, presence: { if: :account_number? }
  validates :account_number, presence: { if: :bank_name? }
end
