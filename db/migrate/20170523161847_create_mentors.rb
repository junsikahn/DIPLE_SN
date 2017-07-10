class CreateMentors < ActiveRecord::Migration[5.0]
  def change
    create_table :mentors do |t|
      t.references :user, null: false

      t.text     :self_introduction, default: ''
      t.string   :bank_name
      t.string   :account_number

      t.datetime :recruited_at
      t.datetime :interviewed_at
      t.datetime :authorized_at

      t.timestamps
    end

    Mentor.create(user_id: 1, self_introduction: '안녕하세요', recruited_at: Time.zone.now, interviewed_at: Time.zone.now, authorized_at: Time.zone.now)
    Mentor.create(user_id: 2, self_introduction: '안녕하세요', recruited_at: Time.zone.now, interviewed_at: Time.zone.now, authorized_at: Time.zone.now)
  end
end
