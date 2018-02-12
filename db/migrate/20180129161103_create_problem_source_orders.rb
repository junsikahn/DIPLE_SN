class CreateProblemSourceOrders < ActiveRecord::Migration[5.0]
  def up
    create_table :problem_source_orders, id: false do |t|
      t.references :problem,         null: false
      t.references :problem_source,  null: false
      t.integer    :order,           null: false
    end

    create_table :problem_subjects, id: false do |t|
      t.references :problem,         null: false
      t.references :subject,         null: false
    end

    problem_source_ids = Problem.pluck(:problem_source_id).uniq
    problem_source_ids.each do |problem_source_id|
      next if problem_source_id.nil?
      Problem.where(problem_source_id: problem_source_id).each do |problem|
        ProblemSourceOrder.create(problem_id: problem.id,
                                  problem_source_id: problem_source_id,
                                  order: problem.problem_source_order)
      end
    end

    subject_ids = Problem.pluck(:subject_id).uniq
    subject_ids.each do |subject_id|
      next if subject_id.nil?
      Problem.where(subject_id: subject_id).each do |problem|
        ProblemSubject.create(problem_id: problem.id, subject_id: subject_id)
      end
    end

    remove_column :problem_collections, :problem_source_id
    drop_table :problem_tags_tmp_problems
    drop_table :tmp_problems
  end

  def down
    create_table :tmp_problems
    create_join_table :problem_tags, :tmp_problems
    add_column :problem_collections, :problem_source_id, :integer
    drop_table :problem_subjects
    drop_table :problem_source_orders
  end
end
