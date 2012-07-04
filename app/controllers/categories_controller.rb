class CategoriesController < ApplicationController
	def show
		@category = Category.find_by_name(params[:name])
		@subcategories = @category.subcategories
	end
end
