class UsersController < ApplicationController
	def show
		@user = User.find_by_id(params[:user_id])
		@websites = []
		@user.endorsements.each do |endorsement|
			@websites << [Website.find_by_id(endorsement.website_id), Website.find_by_id(endorsement.website_id).get_rating("default").get_vote_differential]
		end
		@upvotes = []
		@downvotes = []
		@votes = @user.votes
		@votes.each do |vote|
			if vote.vote_type == 0
				@downvotes << Website.find_by_id(vote.website_id)
			elsif vote.vote_type == 1
				@upvotes << Website.find_by_id(vote.website_id)
			end
		end
	end
end
