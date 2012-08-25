class UsersController < ApplicationController
	def show
		@user = User.find_by_id(params[:user_id])
		@websites = []
		@user.endorsements.each do |endorsement|
			@websites << [Website.find_by_id(endorsement.website_id), Website.find_by_id(endorsement.website_id).get_rating("default").get_vote_differential]
		end
		@num_endorsements = @user.endorsements.count
		@num_upvotes = 0
		@votes = @user.votes.reverse[0..9]
		@users.votes.each do |vote|
			if vote.vote_type == 1
				@num_upvotes = @num_upvotes + 1
			end
		end
	end
	
	def new
		if user_signed_in?
			redirect_to show_profile_path(current_user.id)
		else
			deny_access
		end
	end
	
	def add_profile_pic
		if user_signed_in?
			current_user.picture = params[:user][:picture]
			current_user.save!
			redirect_to show_profile_path(current_user.id)
		else
			deny_access
		end
	end
end
