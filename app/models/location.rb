class Location < ApplicationRecord
  belongs_to :user
  has_one :mentor, through: :user
  has_one :mentee, through: :user

  validates :user_id, presence: true
  validates :full_address, presence: true
  validates :distance, presence: true
  validates :is_checked, acceptance: true
  validate :address_checked?

  def address_checked?
    return if is_checked?
    errors.add(:full_address)
  end
end
