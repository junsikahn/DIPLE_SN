class AddColumnsToProblemSource < ActiveRecord::Migration[5.0]
  def change
    add_column :problem_sources, :location, :integer
    add_column :problem_sources, :institute, :integer
  end
end
