class Rating < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :community
	belongs_to :website
end
