class Admin::ProblemCollection < Standard::ProblemCollection
  has_many :admin_problems, class_name: 'Admin::Problem', through: :problem_collection_to_problems, source: :problem
end
