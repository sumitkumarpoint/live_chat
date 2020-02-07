class AddNameAndImageInChat < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:user_name,:string
    add_column :users,:last_seen,:datetime
    add_attachment :chats,:attached_file
    add_attachment :users,:profile_image
  end
end
