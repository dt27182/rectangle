class Community < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :ratings
  has_many :websites, :through => :ratings
end
