class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  	  session[:user_id] = user.id
  	  redirect_to root_url, notice: "You are now logged in, hurray!"
  	else
  	  flash.now.alert = "Email or password is invalid!"
  	  render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
    reset_session
  	redirect_to root_url, notice: "Logged out!"
  end
end
