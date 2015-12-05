class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper
  include UsersHelper

  before_action :prepare_meta_tags, if: "request.get?"
  helper_method :prepare_meta_tags

  def prepare_meta_tags(options={})
    site        = CONFIG['site']
    title       = options[:title] || meta_tags[:title] || CONFIG['title']
    description = options[:description] || meta_tags[:description] || CONFIG['description']
    image       = options[:image] || meta_tags[:image] || CONFIG['image']
    current_url = request.url
    creator = meta_tags[:twitter][:creator] rescue nil

    # Let's prepare a nice set of defaults
    defaults = {
      reverse:      true,
      site:         site,
      title:        title,
      image:        image,
      description:  description,
      keywords:     CONFIG['keywords'].split,
      twitter: {    title: title,
                    site_name: site,
                    site: '@' + CONFIG['twitter'],
                    creator: creator,
                    card: 'summary',
                    description: description,
                    image: image },
      og: {         url: current_url,
                    site_name: site,
                    title: title,
                    image: image,
                    description: description,
                    type: 'website'}
    }
    options.reverse_merge!(defaults)
    set_meta_tags options
  end

  def set_states
    @states = State.abbreviations
  end

  def authenticate_user
    unless logged_in?
      redirect_to login_path, notice: "Must be logged in"
    end
  end

  def authenticate_admin
    if !admin_or_above? && logged_in?
      redirect_to root_path, notice: "ACCESS DENIED"
    elsif !logged_in?
      authenticate_user
    end
  end

  def authenticate_team_member
    unless session[:user_id] && team_member?
      redirect_to login_path
    end
  end

  def authenticate_recruiter
    unless logged_in? && recruiter_or_above?
      redirect_to login_path, notice: "Access denied."
    end
  end

  def authenticate_update
    #session[:user_id] is stored as a Fixnum. params[:id] is stored as a string
    unless user_id.to_s == params[:id] || (@user.below_admin? && admin_or_above?) || god?
      redirect_to login_path, notice: "You're not allowed to do that"
    end
  end
end
