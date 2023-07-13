class CreateAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :attendees do |t|
      t.string :name
      t.string :phone_number
      t.belongs_to :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
