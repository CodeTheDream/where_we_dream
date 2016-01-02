class SessionsController < ApplicationController
  def new
    if User.any?              # Are there any users?
      if session[:user_id]      # If so, check if user is signed in
        redirect_to root_path     # if so, go to home page, already logged in
      else
        @user = User.new          # if not, go to login page so they sign in
        @page = "Log In"
      end
    else
      session[:user_id] = nil     # if not, clear session and go to login page, just in case db was dropped but didn't log out.
      session[:user_type] = nil
    end
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by_email(email)
    array = [" Try again.", " Sorry.", " Lol."," Keep trying.", " Maybe you wrote it down somewhere?", " Did you spell it right?", " Want to try something else?", ""]
    if user
      if user.activated
        if user.authenticate(password)
          session[:user_id] = user.id
          session[:user_type] = "God" if user.id == 1
          session[:user_type] ||= user.type
          redirect_to root_path, notice: "Welcome #{user.first_name}"
        else
          redirect_to login_path, notice: "Wrong password." + array.sample
        end
      else
        redirect_to login_path, notice: "Your account has not been activated yet. Please check your email for the activation link."
      end
    else
      redirect_to login_path, notice: "We don't have that email." + array.sample
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to root_path, notice: "Successfully logged out"
  end
end
