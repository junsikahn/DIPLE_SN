class Standard::ProblemSource < ApplicationRecord
  has_many :problems, dependent: :destroy
  has_many :problem_collections
end
