class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :careers do |t|
      t.references :user,           null: false
      t.string     :category,       null: false
      t.string     :school
      t.string     :major_1
      t.string     :major_2
      t.string     :major_3
      t.string     :status
      t.date       :entrance_year
      t.date       :graduate_year
      t.datetime   :authorized_at

      t.timestamps
    end

    create_table :favored_subjects do |t|
      t.references :user,           null: false
      t.references :subject,        null: false

      t.timestamps
    end

    create_table :locations do |t|
      t.references :user,           null: false
      t.string     :full_address,   null: false

      t.string     :lng
      t.string     :lat
      t.string     :mountain
      t.string     :localName_1
      t.string     :localName_2
      t.string     :localName_3
      t.string     :main_address
      t.string     :sub_address
      t.string     :building_address
      t.string     :is_new_address
      t.string     :new_address
      t.string     :zipcode
      t.string     :zone_no

      t.integer    :distance

      t.boolean    :is_checked,     default: false

      t.timestamps
    end

    create_table :schedules do |t|
      t.references :user
      t.references :match
      t.integer    :day_of_week,    null: false
      t.integer    :time_start,     null: false
      t.integer    :time_end,       null: false

      t.timestamps
    end

    Schedule.create(match_id: 1, day_of_week: 2, time_start: '19:00', time_end: '21:00')
    Schedule.create(match_id: 1, day_of_week: 4, time_start: '20:00', time_end: '22:00')
    Schedule.create(match_id: 2, day_of_week: 2, time_start: '19:00', time_end: '21:00')
    Schedule.create(match_id: 2, day_of_week: 4, time_start: '20:00', time_end: '22:00')
  end
end
