class AddTrendingAndQualityScoreToRating < ActiveRecord::Migration
  def change
  	add_column :ratings, :trending_score, :float
  	add_column :ratings, :quality_score, :float
  	remove_column :ratings, :score
  end
end
