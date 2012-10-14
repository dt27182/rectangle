class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :registerable
  devise :database_authenticatable,
    :rememberable, :trackable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password,
    :password_confirmation, :remember_me,
    :provider, :uid, :picture

  has_attached_file :picture, :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml", :path => "/profile_pic/:style/:id/:filename"
  validates_attachment_size :picture, :less_than => (0.6).megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpg','image/jpeg', 'image/png', 'image/tiff', 'image/gif', 'image/pjepg', 'image/x-png']

  has_many :endorsements
  has_many :websites
  has_many :votes

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
