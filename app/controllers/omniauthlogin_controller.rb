class OmniauthloginController < ApplicationController
	def create
		render :text => request.env['omniauth.auth']
	end
	def destroy
	end
	def failure
	end
end
