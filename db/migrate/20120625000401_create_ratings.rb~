class CreateRatings < ActiveRecord::Migration
  def up
  	create_table :ratings do |t|
  		t.float :score
  		t.integer :website_id
  		t.integer :community_id
  		t.timestamps
  	end
  end

  def down
  	drop_table :ratings
  end
end
