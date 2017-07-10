class BookHistory < ApplicationRecord
  attr_accessor :subject_id, :book_publisher_id

  scope :original_only, (-> { where(book_unit_id: nil) })
  scope :between, (->(start_date, end_date) { where('(completed_at IS NULL OR completed_at > ?) AND started_at < ?', start_date, end_date) })

  belongs_to :match
  belongs_to :book, class_name: 'Standard::Book'
  belongs_to :book_unit, class_name: 'Standard::BookUnit', optional: true

  belongs_to :original_history, class_name: 'BookHistory', foreign_key: 'book_history_id', optional: true
  has_many :details, class_name: 'BookHistory', foreign_key: 'book_history_id'

  validates :planned_at, presence: { if: 'book_history_id.nil?' }
  validates :book_id, presence: true, uniqueness: { scope: :match_id, on: :create, if: 'book_history_id.nil?' }

  def started_at=(date)
    if date.is_a?(String)
      self[:started_at] =
        if date == 'true'
          Time.zone.now
        elsif date == 'false'
          nil
        else
          Time.zone.parse(date)
        end
    else
      self[:started_at] = super
    end
  end

  def planned_at=(date)
    if date.is_a?(String)
      self[:planned_at] =
        if date == 'true'
          Time.zone.now
        elsif date == 'false'
          nil
        else
          Time.zone.parse(date)
        end
    else
      self[:planned_at] = super
    end
  end

  def completed_at=(date)
    if date.is_a?(String)
      self[:completed_at] =
        if date == 'true'
          Time.zone.now
        elsif date == 'false'
          nil
        else
          Time.zone.parse(date)
        end
    else
      self[:completed_at] = super
    end
  end

  def create_histories(book_history_params)
    return if book_id.nil?
    book = Standard::Book.includes(:units).find(book_id)
    total_count = book.units.size
    book.units.each_with_index do |unit, index|
      date_offset = ((index + 1) * (planned_at - started_at).to_f / total_count.to_f).ceil
      new_list = details.build(book_history_params)
      new_list.book_unit_id = unit.id
      new_list.started_at = nil
      new_list.planned_at = started_at + date_offset.day
    end
  end
end
