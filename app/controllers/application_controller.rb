class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    site   = CONFIG['site']
    title       = CONFIG['title']
    description = CONFIG['description']
    image       = options[:image] || CONFIG['image']
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      reverse:     true,
      site:        site,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[immigrant scholarships schools help where we dream],
      twitter:     {site_name: site,
                    site: '@' + CONFIG['twitter'],
                    card: 'summary',
                    description: description,
                    image: image},
      og:          {url: current_url,
                    site_name: site,
                    title: title,
                    image: image,
                    description: description,
                    type: 'website'}
    }
    options.reverse_merge!(defaults)
    set_meta_tags options
  end

  def authenticate_user
    unless session[:user_id]
      redirect_to login_path
    end
  end

  def authenticate_admin
    unless session[:user_id] && admin_or_above?
      redirect_to login_path
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
    unless session[:user_id].to_s == params[:id] || session[:user_type] == "God"
      redirect_to login_path
    end
  end
end
