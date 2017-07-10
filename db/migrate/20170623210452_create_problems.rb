class CreateProblems < ActiveRecord::Migration[5.0]
  def change
    create_table :problem_sources do |t|
      t.string     :name,            null: false, unique: true
    end
    sources = %w(일일테스트 수능 모의고사)
    sources.each do |s|
      Standard::ProblemSource.create(name: s)
    end

    create_table :problem_collections do |t|
      t.references :subject,         null: false
      t.references :problem_source,  null: false
      t.string     :name,            null: false
      t.integer    :problem_count,   default: 0
      t.integer    :total_score,     default: 0
      t.date       :test_day
      t.boolean    :published,       default: false
      t.integer    :solved_count,    default: 0
      t.timestamps
    end

    create_table :problems do |t|
      t.references :subject,        null: false
      t.integer    :level
      t.integer    :score,          default: 0
      t.text       :content,        limit: 16.megabytes - 1
      t.text       :exm_1
      t.text       :exm_2
      t.text       :exm_3
      t.text       :exm_4
      t.text       :exm_5
      t.string     :answer
      t.text       :explanation,    limit: 16.megabytes - 1
      t.integer    :total_count,    default: 0
      t.integer    :correct_count,  default: 0
      t.references :problem
      t.boolean    :set
      t.attachment :content_image
      t.attachment :answer_image
      t.attachment :audio
      t.timestamps
    end

    create_table :problem_collection_to_problems do |t|
      t.references :problem_collection,  null: false
      t.references :problem,             null: false
      t.integer    :order
    end
  end
end
