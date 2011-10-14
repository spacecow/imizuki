class AddMainPictureIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :main_picture_id, :integer
  end
end
