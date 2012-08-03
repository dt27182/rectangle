class Website < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :url, :description
  has_many :ratings
  has_many :communities, :through => :ratings
  
  def get_trending_score(community_name)
  	community = Community.find_by_name(community_name)
  	return Rating.find_by_website_id_and_community_id(self.id, community.id).trending_score
  end
  
  def get_quality_score(community_name)
  	community = Community.find_by_name(community_name)
  	return Rating.find_by_website_id_and_community_id(self.id, community.id).quality_score
  end
  
  def self.sort_by_trending(community_name)
  	website_list = []
  	Website.find_each do |website|
  		website_list << website
  	end
  	website_list.sort! { |a,b| b.get_trending_score(community_name) <=> a.get_trending_score(community_name) }
  	return website_list
  end
  
  def upvote(community_name)
  	community = Community.find_by_name(community_name)
  	rating = Rating.find_by_website_id_and_community_id(self.id, community.id)
  	rating.num_upvote = rating.num_upvote + 1
  	time_weight = self.created_at.to_r
  	score = rating.num_upvote - rating.num_downvote
  	sign = 0
  	if score > 0
  		sign = 1
  	else 
  		if score < 0
  			sign = -1
  		else
  			sign = 0
  		end
  	end
  	rating.trending_score = log10([score.abs, 1].max) + sign * time_weight / 45000
  	rating.quality_score = rating.num_upvote/(rating.num_upvote + rating.num_downvote)
  	rating.save!
  end
  
  def downvote(community_name)
  	community = Community.find_by_name(community_name)
  	rating = Rating.find_by_website_id_and_community_id(self.id, community.id)
  	rating.num_downvote = rating.num_downvote + 1
  	time_weight = self.created_at.to_r
  	score = rating.num_upvote - rating.num_downvote
  	sign = 0
  	if score > 0
  		sign = 1
  	else 
  		if score < 0
  			sign = -1
  		else
  			sign = 0
  		end
  	end
  	rating.trending_score = log10([score.abs, 1].max) + sign * time_weight / 45000
  	rating.quality_score = rating.num_upvote/(rating.num_upvote + rating.num_downvote)
  	rating.save!
  end
end
