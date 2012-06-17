Rectangle::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

	#homepage
	match '/' => 'index#index', :as => index
	#website listings page for main category
	match '/categories/:name/show', :as => 'categories#show'
	#wesite listings page for sub category
	match '/categories/:name/subcategories/:subname/show', :as => 'subcategories#show'
	#page for website description and comments
	match '/website/:id/show', :as => 'websites#show'
	#page to create review for website
	match '/website/:id/comments/new', :as => 'comments#new'
	#page to create reply for a existing comment
	match '/comment/:id/comments/new', :as => 'comments#newreply'
	#page to input new website
	match '/websites/new', :as => 'websites#new'
  
end
