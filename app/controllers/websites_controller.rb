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
		flash[:notice] = "Website successfully submitted!"
		redirect_to index_path
	end
end
