class Standard::ProblemSource < ApplicationRecord
  has_many :problems
  has_many :problem_collections
end
