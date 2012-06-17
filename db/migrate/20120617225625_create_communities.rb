class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|

      t.timestamps
    end
  end
end
