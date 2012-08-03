class WebsitesController < ApplicationController
	def display_new
		@failed_website = nil
		if !(session[:failed_website].nil?)
			@failed_website = session[:failed_website]
		else
			@failed_website = {:name => "", :url => "", :category => "shopping", :description => ""}
		end
	end
	def commit_new
		category = Category.find_by_name(params[:category][:name])
		if category.nil?
			session[:failed_website] = params[:website]
			session[:failed_category] = params[:category]
			redirect_to display_new_website_path and return
		end
		subcategory = category.subcategories[0]
		new_website = Website.create(params[:website])
		if new_website.id.nil?
			flash[:warning] = "Please fill in all the fields"
			session[:failed_website] = params[:website]
			session[:failed_category] = params[:category]
			redirect_to display_new_website_path and return
		end
		subcategory.websites << new_website
		subcategory.save!
		Community.find_each do |community|
			Rating.create!({:website_id => new_website.id, :community_id => community.id, :trending_score => 0, :quality_score => 0})
		end
		flash[:notice] = "Website successfully submitted!"
		redirect_to index_path
	end
	
	def show
	end
	
	def rate
		rate_type = params[:type]
		communities = ["default"]
		website = Website.find_by_id(params[:id])
		if rate_type == "up"
			communities.each do |community|
				website.upvote(community)
			end
		else
			communities.each do |community|
				website.downvote(community)
			end
		end
	end
end
