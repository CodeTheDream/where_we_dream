class Admin::UsersController < ApplicationController
  before_action :authenticate_admin, except: [:new, :create, :show, :update, :edit]
  before_action :authenticate_update, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column

  # GET /users
  def index
    @users = User.search(params[:search]).order(sort_column + " " + sort_direction)
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @states = School.states
  end

  # GET /users/1/edit
  def edit
    @states = School.states
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      if admin_or_above?
        redirect_to admin_users_path
      else
        session[:user_id] = @user.id
        session[:user_type] = @user.type
        redirect_to root_path, notice: 'User was successfully created.'
      end
    else
      @states = School.states
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      if admin_or_above?
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        redirect_to profile_path, notice: 'Account successfully updated.'
      end
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :city, :state, :email, :password, :user_type, :image, :bio, :facebook_url, :twitter_name, :linkedin_url)
    end

    def sort_column
      %w[first_name last_name user_type].include?(params[:sort]) ? params[:sort] : 'first_name'
    end
end
