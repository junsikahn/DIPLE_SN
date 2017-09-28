class Admin::TmpProblem < ApplicationRecord
  belongs_to :subject, optional: true
end
