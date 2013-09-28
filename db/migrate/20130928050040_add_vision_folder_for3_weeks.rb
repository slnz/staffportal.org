class AddVisionFolderFor3Weeks < ActiveRecord::Migration
  def self.up
    add_attachment :week3s, :vision_folder
  end

  def self.down
    remove_attachment :week3s, :vision_folder
  end
end
