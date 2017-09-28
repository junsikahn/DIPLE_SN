class CreateTmpProblems < ActiveRecord::Migration[5.0]
  def change
    create_table :tmp_problems do |t|
      t.text       :title
      t.integer    :order
      t.text       :content,        limit: 16.megabytes - 1
      t.text       :exm_1
      t.text       :exm_2
      t.text       :exm_3
      t.text       :exm_4
      t.text       :exm_5
      t.string     :answer
      t.integer    :score,          default: 0
      t.text       :explanation,    limit: 16.megabytes - 1
      t.references :subject,        optional: true
      t.integer    :year,           default: 2017
    end

    add_column :problems, :year, :integer, default: 2017
  end
end
