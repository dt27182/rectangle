Rectangle::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

	#homepage
	match '/' => 'index#index', :as => :index
	#website listings page for main category
	match '/categories/:name/show' => 'categories#show', :as => :show_category
	#wesite listings page for sub category
	match '/categories/:name/subcategories/:subname/show' => 'subcategories#show', :as => :show_subcategory
	#page for website description and comments
	match '/website/:id/show' => 'websites#show', :as => :show_website
	#page to create review for website
	match '/website/:id/comments/new' => 'comments#new', :as => :display_new_comment
	#page to create reply for a existing comment
	match '/comment/:id/comments/new' => 'comments#newreply', :as => :display_new_reply
	#page to input new website
	match '/websites/new' => 'websites#new', :as => :display_new_website
  
end
