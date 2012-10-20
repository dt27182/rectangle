Rectangle::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  devise_for :users
  # The priority is based upon order of creation:
  # first created -> highest priority.

  #homepage
  match '/show/:sort_type' => 'index#show', :as => :index_show
  #website listings page for main category
  match '/categories/:name/show/:sort_type' => 'categories#show', :as => :show_category
  #wesite listings page for sub category
  match '/categories/:name/subcategories/:subname/show/:sort_type' => 'subcategories#show', :as => :show_subcategory
  #page for website description and comments
  match '/website/:id/show' => 'websites#show', :as => :show_website
  #page for searching and search results
  match '/search/show' => 'search#show', :as => :show_search
  #page for search form submission
  get '/search/find' => 'search#find', :as => :find_search
  #page to create review for website
  get '/website/:id/comments/new' => 'comments#display_new', :as => :display_new_comment
  put '/website/:id/comments/new' => 'comments#commit_new', :as => :commit_new_comment
  #page to create reply for a existing comment
  get '/comment/:id/comments/new' => 'comments#display_new_reply', :as => :display_new_reply
  put '/comment/:id/comments/new' => 'comments#commit_new_reply', :as => :commit_new_reply
  #page to input new website
  get '/websites/new' => 'websites#display_new', :as => :display_new_website
  #route to take new website form submission
  put '/websites/new' => 'websites#commit_new', :as => :commit_new_website
  #route to rate website
  post '/website/:id/rate/:type' => 'websites#rate', :as => :rate_website
  #route to endorse website
  post '/website/:id/endorse' => 'websites#endorse', :as => :endorse_website
  #route to unendorse website
  post '/website/:id/unendorse' => 'websites#unendorse', :as => :unendorse_website
  #the user profile page
  match '/profile/:user_id' => 'users#show', :as => :show_profile
  #create new user redirect
  match '/user/new' => 'users#new', :as => :new_user
  #route to add profile picture
  post '/user/add_profile_pic' => 'users#add_profile_pic', :as => :add_profile_pic
  root :to => 'index#index'
end
