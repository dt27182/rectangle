class CategoriesController < ApplicationController
	def show
		@subcategories = Category.find_by_name(params[:name]).subcategories
		
	end
end
