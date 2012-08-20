class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|

      t.timestamps
    end
  end
end
