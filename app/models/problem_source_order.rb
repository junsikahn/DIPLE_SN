class ProblemSourceOrder < ApplicationRecord
  belongs_to :problem_source
  belongs_to :problem
end
