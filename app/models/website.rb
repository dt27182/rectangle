class Website < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :ratings
  has_many :communities, :through => :ratings
  def get_trending_score(community_name)
  	community = Community.find_by_name(community_name)
  	return Rating.find_by_website_id_and_community_id(self.id, community.id).trending_score
  end
end
