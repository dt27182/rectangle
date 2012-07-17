class Subcategory < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :category
  has_many :websites
end
