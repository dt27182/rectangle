class SearchController < ApplicationController
  def show
		@search_results = []
		@prev_search = ""
  end
  
  def find
    @prev_type = params[:search_type][:possible_types]
    @prev_search = params[:search_text][:criteria]
    
    @search_results = []
    
    if @prev_search == nil or @prev_search == ""
    	@prev_search = ""
      render :action => "show" and return
    end
    
    if @prev_type == "Users"
      User.all.each do |usr|
        if usr.email.include? @prev_search
    	    @search_results << usr
    	  end
      end
    end
    
    if @prev_type == "Websites"
      matchURL = []
      matchName = []
      Website.all.each do |web|
        if web.url.include? @prev_search
    	    matchURL << web
    	  end
    	  if web.name.include? @prev_search
    	    matchName << web
    	  end
      end
      @search_results = matchURL - matchName + matchName
    end
        
    render :action => "show" and return
  end
end
