class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|

      t.timestamps
    end
  end
end
