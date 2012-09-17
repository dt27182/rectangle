class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_name(params[:name])
    @sort_type = params[:sort_type]
    if @category.nil?
      flash[:warning]  = "The requested category does not exist"
      redirect_to index_path and return
    end
    @websites = nil
    if params[:sort_type] == "quality"
      @websites = @category.websites_sorted_by_quality("default")
    elsif params[:sort_type] == "newest"
      @websites = @category.websites_sorted_by_newest("default")
    else
      @websites = @category.websites_sorted_by_trending("default")
    end
  end
end
