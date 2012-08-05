class Rating < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :community
	belongs_to :website
	
	def get_vote_differential
		return self.num_upvote - self.num_downvote
	end
end
