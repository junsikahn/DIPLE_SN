class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :problem_collection_histories do |t|
      t.references :user,                null: false
      t.references :problem_collection,  null: false
      t.integer    :score
      t.date       :planned_at
      t.date       :completed_at
      t.timestamps
    end

    create_table :problem_histories do |t|
      t.references :user,                null: false
      t.references :subject,             null: false
      t.references :problem_collection,  null: false
      t.references :problem,             null: false
      t.references :problem_collection_history
      t.string     :users_answer
      t.boolean    :correct
      t.boolean    :check
      t.attachment :comment_image
      t.timestamps
    end
  end
end
