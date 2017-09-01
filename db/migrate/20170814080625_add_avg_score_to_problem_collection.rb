class AddAvgScoreToProblemCollection < ActiveRecord::Migration[5.0]
  def up
    add_column :problem_collections, :avg_score, :integer, default: 0
    Standard::ProblemCollection.all.each do |problem_collection|
      problem_collection.update_columns(avg_score: ProblemCollectionHistory.where(problem_collection_id: problem_collection.id).average(:score))
    end
  end

  def down
    remove_column :problem_collections, :avg_score
  end
end
