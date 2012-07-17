class CategoriesController < ApplicationController
	def show
		@category = Category.find_by_name(params[:name])
		@subcategories = @category.subcategories
		@website = @category.sorted_websites("default")
	end
end
