class CreateWebsites < ActiveRecord::Migration
  def up
    create_table :websites do |t|
			t.string :name
			t.string :url
			t.integer :subcategory_id
      t.timestamps
    end
  end
  def down
  	drop_table :websites
  end
end
