class Standard::BookUnit < ApplicationRecord
  default_scope { order(order: :asc) }

  belongs_to :subject
  belongs_to :book

  has_many :book_histories, dependent: :destroy

  validates :page, presence: true
end
