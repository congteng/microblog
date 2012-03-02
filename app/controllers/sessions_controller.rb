class SessionsController < ApplicationController

	def create
		user = User.find_by_email(params[:sss][:email])

		if user && user.authenticate(params[:sss][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = "what's the fuck"
			render :new			
		end
	end

	def new
			
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
