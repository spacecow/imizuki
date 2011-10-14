class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.string :caption
      t.integer :event_id

      t.timestamps
    end
  end
end
