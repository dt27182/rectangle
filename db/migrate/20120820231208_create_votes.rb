class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
			t.integer :user_id
			t.integer :website_id
			t.integer :vote_type
      t.timestamps
    end
  end
end
