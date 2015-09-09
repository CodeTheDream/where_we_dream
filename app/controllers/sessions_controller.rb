class SessionsController < ApplicationController
  def new
    if User.any?                # Are there any users?
      if session[:user_id]        # If so, check if user is signed in
        redirect_to root_path       # if so, go to home page, already logged in
      else
        @user = User.new            # if not, go login page
      end
    else
      session[:user_id] = nil     # if not, clear session and go to login page, just in case db was dropped but didn't log out.
    end
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
