class AddDescriptionColumnToWebsites < ActiveRecord::Migration
  def change
  	add_column :websites, :description, :string
  end
end
