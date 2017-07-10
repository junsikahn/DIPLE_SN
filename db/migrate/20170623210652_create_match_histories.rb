class CreateMatchHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :online_lecture_histories do |t|
      t.references :match,               null: false
      t.references :online_lecture,      null: false
      t.references :online_lecture_list
      t.date       :started_at
      t.date       :planned_at
      t.date       :completed_at
      t.references :online_lecture_history
      t.string     :tag_color
      t.integer    :rating
      t.timestamps
    end

    create_table :comments do |t|
      t.references :match,               null: false
      t.references :user,                null: false
      t.references :subject,             null: false
      t.text       :content
      t.date       :completed_at
      t.references :comment
      t.timestamps
    end

    create_table :problem_collection_histories do |t|
      t.references :match,               null: false
      t.references :problem_collection,  null: false
      t.integer    :score
      t.date       :planned_at
      t.date       :completed_at
      t.timestamps
    end

    create_table :problem_histories do |t|
      t.references :match,               null: false
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

    create_table :book_histories do |t|
      t.references :match,               null: false
      t.references :book,                null: false
      t.references :book_unit
      t.date       :started_at
      t.date       :planned_at
      t.date       :completed_at
      t.integer    :start_page
      t.integer    :planned_page
      t.integer    :completed_page
      t.references :book_history
      t.string     :tag_color
      t.integer    :rating
      t.timestamps
    end
  end
end
