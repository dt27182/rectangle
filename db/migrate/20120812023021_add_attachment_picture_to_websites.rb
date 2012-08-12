class AddAttachmentPictureToWebsites < ActiveRecord::Migration
  def self.up
    change_table :websites do |t|
      t.has_attached_file :picture
    end
  end

  def self.down
    drop_attached_file :websites, :picture
  end
end
