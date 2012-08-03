class AddUpvoteAndDownvoteToRating < ActiveRecord::Migration
  def change
  	add_column :ratings, :num_upvote, :integer
  	add_column :ratings, :num_downvote, :integer
  end
end
