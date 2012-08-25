module WebsitesHelper
	def get_sort_type_display_name(sort_type)
		if sort_type == "trending"
			return "What's Trending"
		elsif sort_type == "quality"
			return "What's Best"
		else
			return "What's New"
		end
	end
end
