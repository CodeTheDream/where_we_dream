class PagesController < ApplicationController
  def home
    @page = 'home'
    @schools = School.search(params[:search])
  end

  def schools
  end
end
