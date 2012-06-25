class CreateSubcategories < ActiveRecord::Migration
  def up
    create_table :subcategories do |t|
			t.string :name
			t.integer :category_id
      t.timestamps
    end
  end
  def down
  	drop_table :subcategories
  end
end
