class Website < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :ratings
  has_many :communities, :through => :ratings
end
