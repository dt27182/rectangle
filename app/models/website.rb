class Website < ActiveRecord::Base
  attr_accessible :name, :url, :description, :picture, :user_id, 
                  :picture_file_name, :picture_content_type, 
                  :picture_file_size, :picture_updated_at
  has_attached_file :picture, :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml", :path => "/:style/:id/:filename"
  validates_attachment_presence :picture
	validates_attachment_size :picture, :less_than => (0.6).megabytes
	validates_attachment_content_type :picture, :content_type => ['image/jpg','image/jpeg', 'image/png', 'image/tiff', 'image/gif', 'image/pjepg', 'image/x-png']
  validates :name, :description, :presence => true
  validates :url, :presence => true, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }
	before_validation :get_full_url
		
  has_many :ratings
  has_many :communities, :through => :ratings
  has_many :endorsements
  has_many :votes
  belongs_to :user
  
	def get_rating(community_name)
		community = Community.find_by_name(community_name)
  	return Rating.find_by_website_id_and_community_id(self.id, community.id)
	end
  
  def self.sort_by_trending(community_name)
  	website_tuple_list = []
  	website_list = []
  	Website.find_each do |website|
  		website_tuple_list << [website, website.get_rating(community_name)]
  	end
  	website_tuple_list.sort! { |a,b| b[1].trending_score <=> a[1].trending_score }
  	website_tuple_list.each do |website_tuple|
  		website_list << [website_tuple[0], website_tuple[1].get_vote_differential]
  	end
  	return website_list
  end
  
  def self.sort_by_quality(community_name)
  	website_tuple_list = []
  	website_list = []
  	Website.find_each do |website|
  		website_tuple_list << [website, website.get_rating(community_name)]
  	end
  	website_tuple_list.sort! { |a,b| b[1].quality_score <=> a[1].quality_score }
  	website_tuple_list.each do |website_tuple|
  		website_list << [website_tuple[0], website_tuple[1].get_vote_differential]
  	end
  	return website_list
  end
  
  def self.sort_by_newest(community_name)
  	website_list = []
  	Website.find(:all, :order => "created_at desc").each do |website|
  		website_list << [website, website.get_rating(community_name).get_vote_differential]
  	end
  	return website_list
  end
  
  def upvote(community_name)
  	community = Community.find_by_name(community_name)
  	rating = Rating.find_by_website_id_and_community_id(self.id, community.id)
  	rating.num_upvote = rating.num_upvote + 1
  	time_weight = self.created_at.to_r
  	score = rating.num_upvote - rating.num_downvote
  	sign = 0.0
  	if score > 0
  		sign = 1.0
  	else 
  		if score < 0
  			sign = -1.0
  		else
  			sign = 0.0
  		end
  	end
  	rating.trending_score = Math.log10([score.abs, 1].max) + sign * time_weight / 45000
  	rating.quality_score = rating.num_upvote.to_f/(1 + rating.num_downvote)
  	rating.save!
  end
  
  def downvote(community_name)
  	community = Community.find_by_name(community_name)
  	rating = Rating.find_by_website_id_and_community_id(self.id, community.id)
  	rating.num_downvote = rating.num_downvote + 1
  	time_weight = self.created_at.to_r
  	score = rating.num_upvote - rating.num_downvote
  	sign = 0.0
  	if score > 0
  		sign = 1.0
  	else 
  		if score < 0
  			sign = -1.0
  		else
  			sign = 0.0
  		end
  	end
  	rating.trending_score = Math.log10([score.abs, 1].max) + sign * time_weight / 45000
  	rating.quality_score = rating.num_upvote.to_f/(1 + rating.num_downvote)
  	rating.save!
  end
  
	def get_full_url
		if !(self.url =~ /(^(http|https):\/\/.*)/)
			self.url = "http://" + self.url
		end
	end
end
