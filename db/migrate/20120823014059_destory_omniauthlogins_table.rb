class DestoryOmniauthloginsTable < ActiveRecord::Migration
  def change
  	drop_table :omniauthlogins
  end
end
