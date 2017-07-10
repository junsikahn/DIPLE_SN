class Career < ApplicationRecord
  belongs_to :user
  has_one :mentor, through: :user
  has_one :mentee, through: :user

  validates :school, presence: true
  validates :major_1, presence: { if: :university? }
  validates :entrance_year, presence: true
  validates :graduate_year, presence: { if: :graduated? }, absence: { unless: :graduated? }
  validates :status, presence: true
  validate :valid_school?
  validate :valid_year?

  def university?
    category == 'univ'
  end

  def graduated?
    status == '2'
  end

  def valid_school?
    if university?
      errors.add(:school) if Standard::University.find_by(name: school).nil?
      errors.add(:major_1) if Standard::Major.find_by(name: major_1).nil?
      errors.add(:major_2) if !major_2.blank? && Standard::Major.find_by(name: major_2).nil?
      errors.add(:major_3) if !major_3.blank? && Standard::Major.find_by(name: major_3).nil?
    else
      errors.add(:school) if Standard::Highschool.find_by(name: school).nil?
    end
  end

  def valid_year?
    return unless !graduate_year.nil? && entrance_year > graduate_year
    errors.add(:graduate_year)
  end
end
