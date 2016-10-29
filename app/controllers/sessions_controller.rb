class SessionsController < ApplicationController
  def new
	end

	def create
		if @user = User.find_by(email: params[:email])
			if @user.authenticate(params[:password])
				@current_user = @user
				session[:user_id] = @user.id
				flash[:success] = 'You have logged in successfully'
				redirect_to root_path
			else


				flash[:error] = 'Email or password is not correct'
				redirect_to login_path
			end
		else
			flash[:error] = 'Cannot find the user'
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = 'You have logged out successfully'

		redirect_to root_path
	end
end
