class IndexController < ApplicationController
	def index
		@websites = Website.sort_by_trending("default")
	end
end
