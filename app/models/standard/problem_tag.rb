class Standard::ProblemTag < ApplicationRecord
  has_and_belongs_to_many :problems
  has_and_belongs_to_many :tmp_problems
end
