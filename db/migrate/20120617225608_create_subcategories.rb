class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|

      t.timestamps
    end
  end
end
