class CreateProblemTag < ActiveRecord::Migration[5.0]
  def up
    create_table :problem_tags do |t|
      t.string :name
      t.string :keyword
      t.integer :refer_count,     default: 0
    end
    create_join_table :problem_tags, :problems
    create_join_table :problem_tags, :tmp_problems

    change_column :problem_collections, :problem_source_id, :integer, null: true
    # 문/이과 구분 - 공통과정 0, 이과 1, 문과 2
    # add_column :problem_collections, :curriculum, :integer
    # e = ProblemCollection.where('name LIKE ?', "%나형%")
    # e.update_all(curriculum: 1)
    # m = ProblemCollection.where('name LIKE ?', "%가형%")
    # m.update_all(curriculum: 2)

    remove_attachment :problems, :audio
    change_column :problems, :subject_id, :integer, null: true
    add_column :problems, :problem_source_id, :integer
    add_column :problems, :problem_source_order, :integer

    add_column :problem_sources, :category, :boolean

    add_timestamps :tmp_problems
    add_column :tmp_problems, :level, :integer
    add_column :tmp_problems, :problem_id, :integer
    add_column :tmp_problems, :problem_source_id, :integer
    # sources = ProblemSource.all
    # sources.each do |source|
    #   Admin::TmpProblem.where(title: source.name).update_all(problem_source_id: source.id)
    # end
  end

  def down
    remove_column :tmp_problems, :problem_source_id
    remove_column :tmp_problems, :problem_id
    remove_column :tmp_problems, :level
    remove_timestamps :tmp_problems

    remove_column :problem_sources, :category

    remove_column :problems, :problem_source_order
    remove_column :problems, :problem_source_id
    change_column :problems, :subject_id, :integer, null: false
    add_attachment :problems, :audio

    remove_column :problem_collections, :curriculum
    change_column :problem_collections, :problem_source_id, :integer, null: false

    drop_table :problem_tags_tmp_problems
    drop_table :problem_tags_problems
    drop_table :problem_tags
  end
end
