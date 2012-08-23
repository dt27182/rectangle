class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, 
  								:password_confirmation, :remember_me,
  								:provider, :uid

  has_many :endorsements
  has_many :websites
  has_many :votes
  has_many :omniauthlogins
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		user = User.where(:provider => auth.provider, :uid => auth.uid).first
		unless user
		  user = User.create(name:auth.extra.raw_info.name,
		                       provider:auth.provider,
		                       uid:auth.uid,
		                       email:auth.info.email,
		                       password:Devise.friendly_token[0,20]
		                       )
		end
		user
	end
	
	def self.new_with_session(params, session)
	end
end
