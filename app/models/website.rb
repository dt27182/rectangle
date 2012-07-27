class Website < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :ratings
  has_many :communities, :through => :ratings
  def get_trending_score(community_name)
  	community = Community.find_by_name(community_name)
  	return Rating.find_by_website_id_and_community_id(self.id, community.id).trending_score
  end
  def self.sorted_websites(community_name, sort_type)
  	website_list = []
  	Website.find_each do |website|
  		website_list << website
  	end
  	if(sort_type == "trending")
  		website_list.sort! { |a,b| b.get_trending_score(community_name) <=> a.get_trending_score(community_name) }
  	end
  	return website_list
  end
end
