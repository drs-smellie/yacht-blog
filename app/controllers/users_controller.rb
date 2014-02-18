class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			render :edit, notice: "User was saved successfully!"
		else
			flash[:error] = "Error saving user. Please try again."
			render :edit
		end 
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_url, notice: "Thank you for signing up!"
		else
			render "new"
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
	end
end

