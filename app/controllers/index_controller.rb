class IndexController < ApplicationController
	def index
		@websites = Website.sorted_websites("default", "trending")
	end
end
