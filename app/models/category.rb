class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :subcategories
  def websites_sorted_by_trending(community_name)
  	website_list = []
  	self.subcategories.each do |subcategory|
  		subcategory.websites.each do |website|
  			website_list << website
  		end
  	end
  	website_list.sort! { |a,b| b.get_trending_score(community_name) <=> a.get_trending_score(community_name) }
  	return website_list
  end
end
