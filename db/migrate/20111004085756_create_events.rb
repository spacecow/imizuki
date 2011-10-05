class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
