Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
  	provider :facebook, "414256088621663", "		1b1a3286958c7ef461b6807f16a5cb7c"
  else
  	provider :facebook, "356093204468680", "	c2fce9fbf2d7d1fc5f561c41e1ce6329"
  end
end

