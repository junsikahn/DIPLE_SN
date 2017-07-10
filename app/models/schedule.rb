class Schedule < ApplicationRecord
  default_scope { order(day_of_week: :asc, time_start: :asc) }

  belongs_to :user, optional: true
  has_one :mentor, through: :user
  has_one :mentee, through: :user
  belongs_to :match, optional: true

  validates :day_of_week, presence: true
  validates :time_start,  presence: true
  validates :time_end,    presence: true

  def time_start=(time)
    return if time.blank?
    if time.is_a?(Hash)
      hours, minutes = time.values_at(4, 5)
    elsif time.is_a?(String)
      time = time.split(':')
      hours, minutes = time.values_at(0, 1)
    end
    if hours.to_i > 24 || minutes.to_i > 60
      errors.add(:time_start)
    else
      self[:time_start] = hours.to_i * 60 + minutes.to_i
    end
  end

  def time_start
    return if self[:day_of_week].nil? || self[:time_start].nil?
    Time.new(2001, 4, self[:day_of_week] + 1, self[:time_start] / 60, self[:time_start] % 60)
  end

  def time_end=(time)
    return if time.blank?
    if time.is_a?(Hash)
      hours, minutes = time.values_at(4, 5)
    elsif time.is_a?(String)
      time = time.split(':')
      hours, minutes = time.values_at(0, 1)
    end
    if hours.to_i > 24 || minutes.to_i > 60
      errors.add(:time_end)
    else
      self[:time_end] = hours.to_i * 60 + minutes.to_i
    end
  end

  def time_end
    return if self[:day_of_week].nil? || self[:time_end].nil?
    Time.new(2001, 4, self[:day_of_week] + 1, self[:time_end] / 60, self[:time_end] % 60)
  end

  def day_name
    case day_of_week
    when 0 then '일요일'
    when 1 then '월요일'
    when 2 then '화요일'
    when 3 then '수요일'
    when 4 then '목요일'
    when 5 then '금요일'
    when 6 then '토요일'
    end
  end
end
