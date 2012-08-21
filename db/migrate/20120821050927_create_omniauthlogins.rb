class CreateOmniauthlogins < ActiveRecord::Migration
  def change
    create_table :omniauthlogins do |t|

      t.timestamps
    end
  end
end
