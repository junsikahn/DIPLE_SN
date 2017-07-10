class Standard::BookPublisher < ApplicationRecord
  has_many :books, dependent: :destroy
end
