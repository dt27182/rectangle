Rectangle::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

	#homepage
	match '/' => 'index#index', :as => :index
	match '/show/:sort_type' => 'index#show', :as => :index_show
	#website listings page for main category
	match '/categories/:name/show/:sort_type' => 'categories#show', :as => :show_category
	#wesite listings page for sub category
	match '/categories/:name/subcategories/:subname/show/:sort_type' => 'subcategories#show', :as => :show_subcategory
	#page for website description and comments
	match '/website/:id/show' => 'websites#show', :as => :show_website
	#page to create review for website
	get '/website/:id/comments/new' => 'comments#display_new', :as => :display_new_comment
	put '/website/:id/comments/new' => 'comments#commit_new', :as => :commit_new_comment
	#page to create reply for a existing comment
	get '/comment/:id/comments/new' => 'comments#disply_new_reply', :as => :display_new_reply
	put '/comment/:id/comments/new' => 'comments#commit_new_reply', :as => :commit_new_reply
	#page to input new website
	get '/websites/new' => 'websites#display_new', :as => :display_new_website
  #route to take new website form submission
  put '/websites/new' => 'websites#commit_new', :as => :commit_new_website
  #route to rate website
  post '/website/:id/rate/:type' => 'websites#rate', :as => :rate_website
end
