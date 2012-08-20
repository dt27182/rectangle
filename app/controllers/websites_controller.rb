class WebsitesController < ApplicationController
	def display_new
		if @failed_website.nil?
			@failed_website = Website.new
		end
		if @failed_category.nil?
			@failed_category = {:name => "shopping"}
		end
	end
	
	def commit_new
		category = Category.find_by_name(params[:category][:name])
		if category.nil?
			params[:website][:picture] = nil
			@failed_website = Website.new(params[:website])
			@failed_category = {:name => "shopping"}
			render :action => "display_new" and return
		end
		subcategory = category.subcategories[0]
		
		params[:website][:url] = params[:website][:url].strip
		if !(params[:website][:url] =~ /(^(http|https):\/\/.*)/)
			params[:website][:url] = "http://" + params[:website][:url]
		end
		
		existing_website = Website.find_by_url(params[:website][:url])
		if existing_website
			flash[:warning] = "The site you tried to submit already exists. You have been redirected to it's profile page."
			params[:website][:picture] = nil
			redirect_to show_website_path(existing_website.id) and return
		end
		
		new_website = Website.create(params[:website])
		if !(new_website.errors.empty?)
			params[:website][:picture] = nil
			@failed_website = new_website
			@failed_category = params[:category]
			render :action => "display_new" and return
		end
		
		subcategory.websites << new_website
		subcategory.save!
		Community.find_each do |community|
			Rating.create!({:website_id => new_website.id, :community_id => community.id, :trending_score => 0, :quality_score => 0, :num_upvote => 0, :num_downvote => 0})
		end
		flash[:notice] = "Website successfully submitted!"
		params[:website][:picture] = nil
		redirect_to index_path
	end
	
	def show
		@website = Website.find_by_id(params[:id])
		if @website.nil?
			flash[:warning] = "The requested website does not exist"
			redirect_to index_path
		end
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
		respond_to do |format|
      format.json { render :json => [] }
    end
	end
end
