class Admin::Problem < Standard::Problem
  def scoring(problem_collection)
    problems = problem_collection.problems.reload
    problem_count = problems.size
    total_score = problems.map(&:score).sum
    problems.select{ |problem| problem.set == true }.each do |problem_set|
      problem_count -= 1
      problem_set.set_problems.each do |set_problem|
        problem_count += 1
        total_score += set_problem.score
      end
    end
    problem_collection.update_columns(problem_count: problem_count, total_score: total_score)
  end
end
