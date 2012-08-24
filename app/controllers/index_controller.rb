class IndexController < ApplicationController
	def index
		@sort_type = "trending"
		@websites = Website.sort_by_trending("default")
		render :template => "index/show"
	end
	def show
		@sort_type = params[:sort_type]
		@websites = nil
		if params[:sort_type] == "quality"
			@websites = Website.sort_by_quality("default")
		elsif params[:sort_type] == "newest"
			@websites = Website.sort_by_newest("default")
		else
			@websites = Website.sort_by_trending("default")
		end
	end
end
