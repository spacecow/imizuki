class AddMainPictureIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :main_picture_no, :integer, :default => 0
  end
end
