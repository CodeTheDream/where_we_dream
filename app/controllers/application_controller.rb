class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    site_name   = "Where We DREAM"
    title       = "Immigrant-friendly schools, scholarships, people"
    description = "Find out about universities and their polices towards immigrant students, about Immigrant-friendly scholarships, and so much more."
    image       = options[:image] || "https://s3.amazonaws.com/where-we-dream/wherewedream.jpg"
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      reverse: true,
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[web software development mobile app],
      twitter:     {site_name: site_name,
                    site: '@thecookieshq',
                    card: 'summary',
                    description: description,
                    image: image},
      og:          {url: current_url,
                    site_name: site_name,
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

  def authenticate_update
    #session[:user_id] is stored as a Fixnum. params[:id] is stored as a string
    unless session[:user_id].to_s == params[:id] || session[:user_type] == "God"
      redirect_to login_path
    end
  end
end
