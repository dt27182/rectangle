class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :subcategories
  def websites_sorted_by_trending(community_name)
  	website_tuple_list = []
  	website_list = []
  	self.subcategories.each do |subcategory|
  		subcategory.websites.each do |website|
  			website_tuple_list << [website, website.get_rating(community_name)]
  		end
  	end
  	website_tuple_list.sort! { |a,b| b[1].trending_score <=> a[1].trending_score }
  	website_tuple_list.each do |website_tuple|
  		website_list << [website_tuple[0], website_tuple[1].get_vote_differential]
  	end
  	return website_list
  end
end
