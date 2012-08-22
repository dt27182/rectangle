class CreateOmniauthlogins < ActiveRecord::Migration
  def change
    create_table :omniauthlogins do |t|
			t.string :provider
			t.integer :provider_uid
			t.integer :user_id
      t.timestamps
    end
  end
end
