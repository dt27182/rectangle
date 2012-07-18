class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :subcategories
  def sorted_websites(community_name)
  	website_list = []
  	self.subcategories.each do |subcategory|
  		subcategory.websites.each do |website|
  			website_list << [website, website.get_trending_score(community_name)]
  		end
  	end
  	return website_list
  end
end
