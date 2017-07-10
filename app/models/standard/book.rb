class Standard::Book < ApplicationRecord
  belongs_to :subject
  belongs_to :publisher, class_name: 'BookPublisher', foreign_key: 'book_publisher_id'

  has_many :units, class_name: 'BookUnit', foreign_key: 'book_id', dependent: :destroy, inverse_of: :book
  accepts_nested_attributes_for :units, allow_destroy: true

  has_many :book_histories, dependent: :destroy
end
