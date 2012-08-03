class CategoriesController < ApplicationController
	def show
		@category = Category.find_by_name(params[:name])
		@subcategories = @category.subcategories
		@websites = @category.websites_sorted_by_trending("default")
	end
end
