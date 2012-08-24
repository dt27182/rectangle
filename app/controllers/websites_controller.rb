class WebsitesController < ApplicationController
	def display_new
		if user_signed_in?
			if @failed_website.nil?
				@failed_website = Website.new
			end
			if @failed_category.nil?
				@failed_category = {:name => "shopping"}
			end
		else
			deny_access
		end
	end
	
	def commit_new
		if user_signed_in?
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
			
			params[:website][:user_id] = current_user.id
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
		else
			deny_access
		end
	end
	
	def show
		@website = Website.find_by_id(params[:id])
		@submitter = User.find_by_id(@website.user_id)
		if user_signed_in?
			@is_endorsed = !Endorsement.find_by_user_id_and_website_id(current_user.id, @website.id).nil?
		else
			@is_endorsed = false
		end
		if @website.nil?
			flash[:warning] = "The requested website does not exist"
			redirect_to index_path
		end
	end
	
	def rate
		if user_signed_in?
			rate_type = params[:type]
			communities = ["default"]
			website = Website.find_by_id(params[:id])
			vote = Vote.find_by_user_id_and_website_id(current_user.id, website.id)
			if vote.nil?
				if rate_type == "up"
					communities.each do |community|
						website.upvote(community)
					end
					vote = Vote.new({:vote_type => 1})
				else
					communities.each do |community|
						website.downvote(community)
					end
					vote = Vote.new({:vote_type => 0})
				end
				current_user.votes << vote
				website.votes << vote
				vote.save!
				respond_to do |format|
				  format.json { render :json => {} }
				end
			else
				respond_to do |format|
				  format.json { render :json => {:status => "rejected"} }
				end
			end
		end
	end
	
	def endorse
		if user_signed_in?
			website = Website.find_by_id(params[:id])
			if website.nil?
				flash[:warning] = "The requested website does not exist"
				redirect_to index_path and return
			end
			endorsement = Endorsement.find_by_user_id_and_website_id(current_user.id, website.id)
			if endorsement.nil?
				Endorsement.create!({:user_id => current_user.id, :website_id => website.id})
				flash[:notice] = "This website has been added to your endorsements"
				redirect_to show_website_path(params[:id])
			else
				flash[:warning] = "You have already endorsed the website"
				redirect_to show_website_path(params[:id])
			end
		else
			deny_access_and_come_back_to(show_website_path(params[:id]))
		end
	end
	
	def unendorse
		if user_signed_in?
			website = Website.find_by_id(params[:id])
			if website.nil?
				flash[:warning] = "The requested website does not exist"
				redirect_to index_path and return
			end
			endorsement = Endorsement.find_by_user_id_and_website_id(current_user.id, website.id)
			if endorsement.nil?
				flash[:warning] = "You have not endorsed this website"
				redirect_to show_website_path(params[:id])
			else
				endorsement.destroy
				flash[:notice] = "You have successfully unendorsed this website"
				redirect_to show_website_path(params[:id])
			end
		else
			deny_access_and_come_back_to(show_website_path(params[:id]))
		end
	end
end
