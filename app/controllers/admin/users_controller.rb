class Admin::UsersController < ApplicationController
  before_action :authenticate_team_member, only: :index
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_states, only: :edit
  before_action :authenticate_update, only: [:edit, :update]
  helper_method :sort_column

  # GET /users
  def index
    @users = User.search(params[:search]).order("#{sort_column} #{sort_direction}").page(params[:page])
  end

  # GET /users/1
  def show
    prepare_meta_tags image: @user.image.url
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      if admin_or_above?
        UserMailer.activate(@user).deliver_now
        redirect_to admin_users_path
      else
        UserMailer.activate(@user).deliver_now
        # redirect_to root_path, notice: 'User was successfully created. Please check your email to activate your account.'
        redirect_to wait_path
      end
    else
      @states = State.abbreviations
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      if admin_or_above?
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        redirect_to user_path(@user), notice: 'Account successfully updated.'
      end
    else
      @states = State.abbreviations
      message = @user.errors.full_messages.join "\n"
      flash.notice = "#{message}"
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end

  def activate
    user_id = params[:foo]
    token = params[:bar]
    user = User.find(user_id) rescue nil
    if user && (token == user.password_digest.clean)
      activated = user.activated
      user.update(activated: true)
      session[:user_id] ||= user.id
      session[:user_type] ||= user.type
      redirect_to root_path, notice: activated ? "Your account is already activated" : "Your account has been activated."
    else
      redirect_to login_path, notice: "Something went wrong. Try again or try something else."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :city, :state, :email, :password, :user_type, :image, :team_contribution, :bio, :facebook_url, :twitter_name, :linkedin_url)
    end

    def sort_column
      %w[first_name last_name user_type].include?(params[:sort]) ? params[:sort] : 'first_name'
    end
end
