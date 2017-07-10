class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.references :mentor,         null: false
      t.references :mentee,         null: false
      t.text       :study
      t.text       :school
      t.text       :history
      t.text       :korean
      t.text       :english
      t.text       :math

      t.timestamps
    end

    Match.create(mentor_id: 1, mentee_id: 1)
    Match.create(mentor_id: 2, mentee_id: 1)
  end
end
